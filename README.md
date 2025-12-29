# IBAN-Calculator (MIPS Assembler Project)

This repository contains the source code for an IBAN calculator implemented in MIPS assembler, as part of the Programming 2 course (SS 2023) at Saarland University (p. 1). The project involves converting bank account numbers (KNR) and bank codes (BLZ) to a German IBAN, or extracting these details from an existing IBAN (p. 1).

## **Project Structure**
Folder | Content
src/	: Contains the primary MIPS assembler source files (.asm) (p. 1).
tests/	: Contains public (pub) and student-written tests (p. 3).
testbox/	: A temporary folder used for debugging individual tests in MARS (p. 3).

## **Functionality & Tasks**

The project is divided into several subroutines located in specific files within `src/`:

*   **Task 1: Extract BLZ and KNR:** `src/iban2knr.asm`
*   **Task 2: Remainder calculation:** `src/moduloStr.asm`
*   **Task 3: Validate IBAN check digits:** `src/validateChecksum.asm`
*   **Task 4: Generate IBAN:** `src/knr2iban.asm`
*   **Task 5 (Bonus):** `src/bonus/validateChecksum.asm`

## **How to Run & Test**
The project uses the MARS MIPS simulator (specifically the version installed on the course's VM) (p. 4).

## **Running in MARS**
Open the cloned directory in MARS.
Ensure "Assemble all files in directory" and "Initialize Program Counter to global ‘main’ if defined" are activated in the Settings menu (p. 1).

## **Running Automated Tests**
Public tests are executed using a Python script located in the root directory (p. 3).

## **Run all public tests**
./run_tests.py 

## **Run a specific test (e.g., test_check_win1)**
./run_tests.py -t test_check_win1

## **Run public and student tests**
./run_tests.py -d pub student
