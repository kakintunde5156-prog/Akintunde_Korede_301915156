```python
# No complex formatting or data calculation required.
# Generating a markdown response for a discussion-based portfolio strictly adhering to user instructions and constraints.


```

Here is your completed **Portfolio 5 `README.md**` discussion on distributed and cloud databases, adapted for the RanGo e-commerce platform according to the exact structure in your images.

```markdown
# Portfolio 5 Distributed and Cloud Database Exercise

## Current setup
This is a discussion of a proposed distributed setup for the RanGo e-commerce MongoDB event records. The practical work uses one MongoDB server and PostgreSQL running locally in the same Codespace. No MongoDB replica set, sharding, or failover test is configured in this example. Being hosted in Codespaces does not give the database multiple copies on separate servers.

## Proposed replication
Replication keeps copies of the same data on different database servers. A proposed MongoDB replica set for RanGo has three voting, data-holding members:

| Member | Starting role | Location |
| :--- | :--- | :--- |
| A | Primary: accepts event writes | Host 1 |
| B | Secondary: copies event changes | Host 2 |
| C | Secondary: copies event changes | Host 3 |

The hosts are placed in separate failure zones so one host or zone failure does not remove all copies. When Alice's shipped order event (E002) is written to the primary, the secondaries copy it asynchronously. A secondary can therefore briefly have older event data.
[Replication](https://www.mongodb.com/docs/manual/replication/)

## Failure and consistency
If member A fails, the two remaining members can elect an eligible secondary as the new primary, provided they can communicate and form a majority. New writes pause during the election, so failover is not instant or guaranteed without the required members. If only one of the three voting members remains reachable, there is no majority to elect a writable primary.
[Elections](https://www.mongodb.com/docs/v8.0/core/replica-set-elections/)

For important events, the proposed design requests majority write acknowledgement: at least two of these three voting, data-holding members must acknowledge the write. This improves protection against losing an acknowledged event during a single-member failure, but adds waiting and requires a reachable majority. Recent-event queries prefer the primary; secondary reports may lag. Current e-commerce operational decisions (like stock availability or financial transactions) still come from PostgreSQL and its transaction rules, not from a possibly stale NoSQL event copy.
[Write concern](https://www.mongodb.com/docs/v8.0/reference/write-concern/)

## Sharding and cloud deployment
Sharding splits records across groups of servers; replication copies the same records. Four example e-commerce events do not justify sharding. If event volume grows enough to exceed one replica set's practical capacity, shard-key selection needs evidence about query patterns and data distribution. No sharding is implemented here.
[Sharding](https://www.mongodb.com/docs/manual/sharding/)

A cloud version could use a suitable managed MongoDB deployment, with database authentication, encrypted connections, restricted network access, and scheduled backups that are tested by restoring them. Available features and costs need checking for the chosen deployment. Replication does not replace backups: an accidental deletion can also reach the copies. MongoDB replication alone does not protect the whole RanGo platform; PostgreSQL needs its own availability and recovery plan. It also does not automatically synchronise the two databases.
[Atlas backup options](https://www.mongodb.com/docs/atlas/backup-restore-cluster/)

```