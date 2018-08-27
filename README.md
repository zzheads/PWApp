# PWApp
Test application for Sharp Developers

## PW Application Overview
The application is for Parrot Wings (PW, “internal money”) transfer between system users.
The application will be very “polite” and will inform a user of any problems (i.e. login not successful, not enough PW to remit the transaction, etc.)

### User registration 
Any person on Earth can register with the service for free, providing their Name (e.g. John Smith), valid email (e.g. jsmith@gmail.com) and password. 
When a new user registers, the System will verify, that the user has provided a unique (not previously registered in the system) email, and also provided human name and a password. These 3 fields are mandatory. Password is to be typed twice for justification. No email verification required.
On successful registration every User will be awarded with 500 (five hundred) PW starting balance.

### Logging in 
Users login to the system using their email and password.
Users will be able to Log out.
No password recovery, change password, etc. functions required.

### PW
The system will allow users to perform the following operations:
- See their Name and current PW balance always on screen.
- Create a new transaction. To make a new transaction (PW payment) a user will choose the recipient by querying the User list by name (autocomplete). 
When a recipient chosen, entering the PW transaction amount. The system will check that the transaction amount is not greater than the current user balance.
- Committing the transaction. 
Once transaction succeeded, the recipient account will be credited (PW++) by the entered amount of PW, and the payee account debited (PW--) for the same amount of PW. The system shall display PW balance changes immediately to the user.

- (Optional) Create a new transaction as a copy from a list of their existing transactions: create a handy UI for a user to browse their recent transactions, and select a transaction as a basis for a new transaction. Once old transaction selected, all its details (recipient, PW amount) will be copied to the new transaction.

- Review a list (history) of their transactions. A list of transactions will show the most recent transactions on top of the list and display the following info for each transaction:
1. Date/Time of the transaction
2. Correspondent Name
3. Transaction amount, (Debit/Credit for PW transferred)
4. Resulting balance

- (Optional) Implement filtering and/or sorting of transaction list by date, correspondent name and amount. 
