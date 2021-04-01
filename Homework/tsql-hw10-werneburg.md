# TSQL Homework 10

---
Dakin Werneburg  
3/30/2021

## 1. What is the purpose of transactions? Why do we use transactions in SQL scripts?
- Transactions are meant to group units of work so that the database is maintained in a consistent state.

## 2. Briefly describe each of the ACID properties.
- Atomicity is the smallest unit of work.  It all or nothing transactions
- Consistency is insuring that all integrity rules have been applied before any transactions.
- Isolation ensures that transactions access only consistent data.
- Durabitly means changes are made to the database transaction log first before any actually changing the data.

## 3. What do we mean when we talk about the granularity of locks?
- Granularity of locks refers to how much data is locked.  Row lock means only one individual row where a page is many rows that are locked, and this changes depending on the granularity. 

## 4. What do we mean when we talk about the modes of locks?
- The mode of locks refers to the how much control over the resource.  For example exclusive mean that transaction is the only one able to read and modify the data, where as shared means it is in line for an exclusive lock, but in the meantime can read only.

## 5. In your own words, describe blocking, and give an example.
- Blocking refers to the line of code prevented from executing because there is a hold on the resource and until the hold has been released, it will skip execution until it checks again to see if the lock has been released.  For example, if one customer order an item at the same time another customer placed the order, before the transaction is complete it must wait unitl one of them purchased the item before knowing total items on hand.

## 6. What are the properties of locks? That is, list the column name and column type of the fields in sys.dm tran locks.
- Column name                    Data type
- resource_type                    nvarchar(60)
- resource_subtype                nvarchar(60)
- resource_database_id            int
- resource_description            nvarchar(256)
- resource_associated_entity_id    bigint
- resource_lock_partition            int
- request_mode                    nvarchar(60)
- request_type                    nvarchar(60)
- request_status                    nvarchar(60)
- request_reference_count            smallint
- request_lifetime                int
- request_session_id                int
- request_exec_context_id            int
- request_request_id                int
- request_owner_type                nvarchar(60)
- request_owner_id                bigint
- request_owner_guid                uniqueidentifier
- request_owner_lockspace_id        nvarchar(32)
- lock_owner_address                varbinary(8)
- pdw_node_id                        int

## 7. What are the properties of sessions? That is, list the column name and column type of the fields in sys.dm exec connections.
- session_id int
- connect_time datetime
- last_read datetime
- last_write datetime
- most_recent_sql_handle varbinary(64)

## 8. What are the requests of sessions? That is, list the column name and column type of the fields in sys.dm exec requests.
- session_id               smallint
- blocking_session_id      smallint
- command                  nvarchar(32)
- sql_handle               varbinary(64)
- database_id              smallint
- wait_type                nvarchar(60)
- wait_time                int
- wait_resource            nvarchar(256)

## 9. What is an isolation level? Give an example of the operation of an isolation level.
- Isolation levels determine the level of consistency you get when you interact with data. For example "SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;".  This means that the reader can read uncommitted changes (also known as dirty reads).

## 10. (Not in the book.) What do we mean when we say that an object is serializable?
- When an item is serializable it means that it can be converted to something that can be stored or transmitted and retrieved in same order.

## 11. What is an deadlock? Give an example of a deadlock?
- Deadlock means that a resource is locked because one two different process need to wait for the other to use the resource.  TSQL by default handles deadlock by rolling back the transaction of the transaction that so far has performed the least amount of work, or set manually via a priority.