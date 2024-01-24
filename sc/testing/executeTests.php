<?php

date_default_timezone_set('UTC');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Define application's root directory
define('ROOT_DIR', __DIR__);

// Define application's configuration directory
define('TESTS_DIR', ROOT_DIR . '/tests');

if(!file_exists(TESTS_DIR)) {
    echo "Error: Tests directory not found.\n";
    exit(1);
}

if($argc == 2) {
    $testFunc = $argv[1];
} else {
    $testFunc = null;
    echo "\nNOTICE: Executing all tests requires approx.\n";
    echo "  Wallet 1: 12 Dero\n";
    echo "  Wallet 2:  1 Dero\n";
    echo "  Wallet 3:  2 Dero\n\n";
}

$tests = array();
$funcTestDirs = glob(TESTS_DIR . '/*', GLOB_ONLYDIR);
foreach($funcTestDirs as $funcTestDir) {
    if($testFunc !== null && $testFunc !== basename($funcTestDir)) {
        continue;
    }

    $testDirs = glob($funcTestDir . '/*', GLOB_ONLYDIR);
    natsort($testDirs);
    foreach($testDirs as $testDir) {
        $tests[] = array(
            'func' => basename($funcTestDir),
            'before' => $testDir . '/before.json',
            'after' => $testDir . '/after.json',
            'diff' => $testDir . '/diff.json',
            'run' => $testDir . '/run.sh',
            'preHook' => $testDir . '/preHook.sh',
            'postHook' => $testDir . '/postHook.sh'
        );
    }
}

for($i=0; $i<count($tests); $i++) {
    if($i>0) sleep(1);
    echo "Testing '" . $tests[$i]['func'] . "' / Running test: #" . ($i+1) . "\n";
    if(isset($tests[$i]['preHook']) && file_exists($tests[$i]['preHook'])) {
        echo "Executing preHook: " . $tests[$i]['preHook'] . "\n";
        $output = array();
        exec($tests[$i]['preHook'], $output, $return_var);
        sleep(1);
    }

    echo "Executing Test\n";
    $output = array();
    exec($tests[$i]['run'], $output, $return_var);
    $now = time();
    // output:
    // {"jsonrpc":"2.0","id":"0","result":{"txid":"ab8b1a41c17671fb50983ccbc64d145f92b90a53c48ff72b0290a33cf62688a3"}}
    // {"jsonrpc":"2.0","id":"0","result":{"txid":"6fe5fe0befe2ae773bd5f1fea5d14ecf35381c1528af2d724111034dba630191"}}

    if ($return_var !== 0) {
        echo "Error: Command failed with return value $return_var\n";
    } else {
        $before = json_decode(file_get_contents($tests[$i]['before']), true);
        $after = json_decode(file_get_contents($tests[$i]['after']), true);
        $changedValues = array();

        if(isset($before['result']['stringkeys']) && isset($after['result']['stringkeys'])) {
            // Check for changes and deletions
            foreach ($before['result']['stringkeys'] as $key => $value) {
                if(!isset($after['result']['stringkeys'][$key])) {
                    $changedValues["deleted"][$key] = $value;

                    if(getReadableKey($key) != $key || getReadableValue($value) != $value) {
                        $changedValues["deleted"][getReadableKey($key)."_human"] = getReadableValue($value);
                    }
                    if(getOffset($value) !== null) {
                        $changedValues["deleted"][getReadableKey($key)."_offset"] = getOffset($value);
                    }
                } elseif ($after['result']['stringkeys'][$key] !== $value) {
                    $changedValues["changed"]["before"][$key] = $before['result']['stringkeys'][$key];
                    $changedValues["changed"]["after"][$key] = $after['result']['stringkeys'][$key];

                    if(getReadableKey($key) != $key || getReadableValue($value) != $value || getReadableValue($after['result']['stringkeys'][$key]) != $after['result']['stringkeys'][$key]) {
                        $changedValues["changed"]["before"][getReadableKey($key)."_human"] = getReadableValue($value);
                        $changedValues["changed"]["after"][getReadableKey($key)."_human"] = getReadableValue($after['result']['stringkeys'][$key]);
                    }
                    if(getOffset($value) !== null) {
                        $changedValues["changed"]["before"][getReadableKey($key)."_offset"] = getOffset($value);
                        $changedValues["changed"]["after"][getReadableKey($key)."_offset"] = getOffset($after['result']['stringkeys'][$key]);
                    }
                }
            }

            // Check for additions
            foreach ($after['result']['stringkeys'] as $key => $value) {
                if (!isset($before['result']['stringkeys'][$key])) {
                    $changedValues["added"][$key] = $value;

                    if(getReadableKey($key) != $key || getReadableValue($value) != $value) {
                        $changedValues["added"][getReadableKey($key)."_human"] = getReadableValue($value);
                    }
                    if(getOffset($value) !== null) {
                        $changedValues["added"][getReadableKey($key)."_offset"] = getOffset($value);
                    }
                }
            }
        }

        if(isset($before['result']['balance']) && isset($after['result']['balance'])) {
            if($before['result']['balance'] !== $after['result']['balance']) {
                $changedValues["changed"]["before"]["balance"] = $before['result']['balance'];
                $changedValues["changed"]["after"]["balance"] = $after['result']['balance'];
            }
        }

        if(isset($tests[$i]['postHook']) && file_exists($tests[$i]['postHook'])) {
            sleep(1);
            echo "Executing postHook\n";
            $output = array();
            exec($tests[$i]['postHook'], $output, $return_var);
        }

        if(count($changedValues) > 0) {
            $changedValues['timestamp'] = $now;
            $changedValues['timestamp_human'] = date('Y-m-d H:i:s', $now);
            file_put_contents($tests[$i]['diff'], json_encode($changedValues, JSON_PRETTY_PRINT));
        } else {
            file_put_contents($tests[$i]['diff'], '');
        }
    }
}

function is_unix_timestamp($value) {
    $offset = 60 * 60 * 24 * 365 * 2;
    if(!is_numeric($value) || $value < time() - $offset || $value > time() + $offset) {
        return false;
    }
    $date = date('Y-m-d H:i:s', $value);
    return $date !== false && strtotime($date) === (int)$value;
}

function hex_decode(string $string) {
    if (ctype_xdigit((string) $string) && strlen($string) % 2 == 0) {
        $decoded = hex2bin($string);
        if (preg_match('/[^\x1f-\x7e]/', $decoded)) {
            return false;
        }
        return $decoded;
    }
    return false;
}

function decode_hex_key($key) {
    $prefixes = ['t,list,', 't,l,'];
    $decoded = false;
    foreach ($prefixes as $prefix) {
        if (strpos($key, $prefix) === 0) {
            list($hex_string, $suffix) = explode(",", substr($key, strlen($prefix)), 2) + [1 => ''];
            $decoded_string = hex_decode($hex_string);
            if ($decoded_string !== false) {
                $decoded = $prefix . $decoded_string . ($suffix ? $suffix : '');
            }
        }
    }
    return $decoded;
}


function getReadableKey($key) {
    if(decode_hex_key($key)) {
        $readableKey = decode_hex_key($key);
    } else {
        $readableKey = $key;
    }

    return $readableKey;
}


function getReadableValue($value) {
    if(hex_decode($value)) {
        $readableValue = hex_decode($value);
    } elseif(is_unix_timestamp($value)) {
        $readableValue = date('Y-m-d H:i:s', $value);
    } else {
        $readableValue = $value;
    }
    
    return $readableValue;
}

function getOffset($value) {
    if(hex_decode($value) === false && is_unix_timestamp($value) === true) {
        $offset = $value - time();
    } else {
        $offset = null;
    }

    return $offset;
}    