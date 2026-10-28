// Portfolio 4: NoSQL and Advanced Data Models
// Case Study: RanGo E-commerce Platform

// 1. Select the MongoDB database
db = db.getSiblingDB("rango_events");

// Check that the collection is empty before inserting
db.order_events.countDocuments();

// 2. Insert four example order events
db.order_events.insertMany([
  {
    _id: "EV001", event_type: "order_placed",
    occurred_at: ISODate("2026-10-01T08:30:00Z"),
    customer: { customer_id: 1, email: "alice@example.com" },
    product: { product_id: 1, name: "Wireless Mouse" },
    details: { total_amount: 25.00, status: "pending" }
  },
  {
    _id: "EV002", event_type: "order_shipped",
    occurred_at: ISODate("2026-10-02T14:15:00Z"),
    customer: { customer_id: 1, email: "alice@example.com" },
    product: { product_id: 1, name: "Wireless Mouse" },
    details: { carrier: "FastLogistics", tracking_number: "FL123456789" }
  },
  {
    _id: "EV003", event_type: "order_placed",
    occurred_at: ISODate("2026-10-05T09:00:00Z"),
    customer: { customer_id: 2, email: "bob@example.com" },
    product: { product_id: 2, name: "Mechanical Keyboard" },
    details: { total_amount: 85.00, status: "pending" }
  },
  {
    _id: "EV004", event_type: "order_placed",
    occurred_at: ISODate("2026-10-06T10:20:00Z"),
    customer: { customer_id: 3, email: "carol@example.com" },
    product: { product_id: 3, name: "USB-C Hub" },
    details: { total_amount: 40.00, status: "pending" }
  }
]);

// 3. Query: Count the documents
db.order_events.countDocuments();

// 4. Query: Read an entity's ordered event history (Alice's orders)
db.order_events.find(
  { "customer.email": "alice@example.com" },
  { _id: 1, event_type: 1, occurred_at: 1, details: 1 }
).sort({ occurred_at: 1, _id: 1 }).toArray();

// 5. Query: Find specific nested details (orders shipped by FastLogistics)
db.order_events.find({ "details.carrier": "FastLogistics" }).toArray();