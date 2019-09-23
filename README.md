# IOX Test Project
IOX Test Project is used for testing different IOX Devices such as DIO, MODBUS, METER, DCM.
This testsuite contains a collection of options such as executing individual testcases, executing testcases using a file, executing all testcases of a device, excluding a specific test, exclude using     a file containing testcases to be excluded or all the testcases.

The latest image is available at : [iox_test_suite](https://github.com/unmesh1511/final_test.git)

## How to install the testsuite

  
## Prerequisites for using testsuite

  
 1. mosquitto broker
 2. mosquitto clients
 3. python
  
## How to run
```bash
./ioxtest
  ```
  
 IOX testsuite also provides you with the following options :
 
   **-g**
 
     Used to run the testcases as groups.
     for example : -g dio or -g dio,dio/do or -g dio,modbus etc
 
   **-i**
 
     Used to run individual testcases.
     for example : -i dio/dio_create or -i modbus/modbus_create **or** meter/3phase/3phase_provision etc
 
   **-l**
 
     Used to run testcases mentioned in a file.
     for example : -l <FILE_NAME>
 
     example of a FILE :
                         modbus/modbus_create
                         dio/din/din_deep
                         dio/relay/relay_get
                         meter/3phase/3phase_delete
 
   **-x**
      
     Used to exclude a testcase.
     for example : -x dio/dio_create or modbus/modbus_create 
  
   **-X**
   
      Used to exclude testcases mentioned in a file.
      for example : -X <FILE_NAME>
      
## Testsuite Design 
The IOX testsuite has a main directory as **iox_test**.
The iox_test directory has different directories corresponding to different devices such as **dio, modbus, meter** as well as **src, result** directories having source code and logs respectively.
Inside each device directories there are testcases for different actions such as **create, provision, delete** etc.
    
```bash
├── dcm
│   ├── dcm_*
│   ├── files.list
│   
├── dio
│   ├── dio_*
│   ├── files.list
│
├── common.sh
│
├── env_var.sh
│
├── errors.sh
│
├── generic
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
├── result
│
├── README.md
│
├── rs232
│
├── ioxtest.sh
```
    
    
    
    
    
    
    
    
    
    
    
    
    
    
