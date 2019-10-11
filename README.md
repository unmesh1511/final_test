# IOX Test Project

IOX Test Project is used for testing different IOX Devices such as DIO, MODBUS, METER.
This testsuite provides you the collection of options to execute all the test cases or only the selected testcases. We can also provide the list of testcases that we want to exclude during the run.


## How to install the testsuite

IOX Test Project is executed on Apollo to test IOX functionality. Get the latest test-suite "iox_test" directory from bitbucket IOX "develop" repository. Copy the mention directory on Apollo and update the required configurations in iox.config before executing test-suite.
  
## Prerequisites for using testsuite
  
 1. mosquitto broker
 2. mosquitto clients
 3. python
 4. sshpass
 5. minicom for IOX TASH logs
 6. column command
 7. boxes command
 
## Command to install above packages 
```bash
 sudo apt-get install bsdmainutils sshpass boxes minicom 
```
 
## How to run
```bash
./ioxtest
  ```
  
 IOX testsuite also provides you with the following options :
 
   **-g**
 
     Used to run the testcases as groups. Groups are the directories present inside the test-suite.
     for example : -g dio or -g dio,dio/do or -g dio,modbus etc
 
   **-i**
 
     Used to run individual testcases.
     for example : -i dio/dio_create.sh or -i modbus/modbus_create.sh or meter/3phase/3phase_provision.sh etc
 
   **-l**
 
     Used to run testcases mentioned in a file.
     for example : -l <FILE_NAME>
 
     example of a FILE :
                         modbus/modbus_create.sh
                         dio/din/din_deep.sh
                         dio/relay/relay_get.sh
                         meter/3phase/3phase_delete.sh
 
   **-x**
      
     Used to exclude a testcase.
     for example : -x dio/dio_create.sh or modbus/modbus_create.sh 
  
   **-X**
   
      Used to exclude testcases mentioned in a file.
      for example : -X <FILE_NAME>
      
## Testsuite Design 
The IOX testsuite has a main directory as **iox_test**.
The iox_test directory has different directories corresponding to different devices such as **dio, modbus, meter** as well as **result** directory having respective testcase log.
Inside each device directory there are testcases for different actions such as **create, provision, delete** etc. as well as for configurations such as **dvc, deep_topic, mode, port, get service, monitor service**.
    
```bash
├── dcm
│   ├── dcm_*
│   ├── files.list
│   
├── dio
│   ├── dio_*
│   ├── do
│   ├── din
│   ├── relay
│   ├── files.list
│
├── common.sh
│
├── env_var.sh
│
├── errors.sh
│
├── meter
│   ├── 3phase
│       ├── 3phase_*
│       ├── files.list 
│
├── iox.config
│
├── iox_info.sh
│
├── long_run
│   ├── iox_test_dio_meter.sh
│
├── ota
│   ├── iox_ota_client.sh
│   ├── ota_version.sh
│
├── modbus
│   ├── modbus_*
│   ├── files.list
│
├── sys
│   ├── iox_replace.sh
│   ├── files.list
│
├── apollo_reboot_iox_test.sh
|
├── result
│
├── README.md
│
├── rs232
│
├── ioxtest.sh
```
