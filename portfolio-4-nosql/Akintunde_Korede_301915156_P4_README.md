# Portfolio 4 NoSQL and Advanced Data Models

## Document model
The `rango_events` database contains an `order_events` collection.
Each document records one order placement or shipment event. Its fields are `_id`, `event_type`, `occurred_at`, `customer`, `order` and `details`. Customer email/ID and order ID/total are embedded in the event. Order placement details contain a payment method; shipment details contain a carrier and tracking number.

Example shipment document:

    {
      _id: "E002", event_type: "order_shipped",
      occurred_at: ISODate("2026-10-26T14:30:00Z"),
      customer: { customer_id: 1, email: "alice@example.com" },
      order: { order_id: 1, total_amount: 45.00 },
      details: { carrier: "FastLogistics", tracking_number: "FL123" }
    }

## Implementation and results
Four fictional documents are inserted using mongosh. The count is 4.
The order ID 1 history query returns E001 (order_placed) and E002 (order_shipped).
Searching details.carrier for FastLogistics returns E002, Alice's shipped order.
The events are entered separately; PostgreSQL is not changed.

## Why MongoDB fits
An event can keep its customer, order and event-specific details together.
Order placement and shipment details can differ without requiring every event to have every field. A separate document per event lets the history grow without adding everything to one large document. The copied names and amounts are snapshots and do not automatically track SQL changes.
PostgreSQL still handles the transactional e-commerce rules. This example does not enforce SQL foreign keys in MongoDB or synchronise the two databases.

## Files
* [MongoDB Setup Notes](Akintunde_Korede_301915156_P4_Setup.md)
* [MongoDB JavaScript Queries](Akintunde_Korede_301915156_P4_MongoDB.js)
* [MongoDB Connection Proof](screenshots/Akintunde_Korede_301915156_P4_MongoDBConnection.png)
* [Events and Queries Proof](screenshots/Akintunde_Korede_301915156_P4_EventsAndQueries.png)

## References
* [MongoDB Data Modeling Introduction](https://www.mongodb.com/docs/manual/core/data-modeling-introduction/)
* [Query on Nested Documents](https://www.mongodb.com/docs/manual/tutorial/query-embedded-documents/)