// First, remove any existing nodes and relationships in the graph.
MATCH(n) OPTIONAL MATCH (n)-[r]-() DELETE r, n;

// ----- Example #1 -----
// A simple binary relation.

// Robot_1 eats batteries.

// AtomSpace syntax:
// (EvaluationLink
//   (PredicateNode "eats")
//   (ListLink
//    (ConceptNode "Robot_1")
//    (ConceptNode "Batteries")))

CREATE
  (n1:Concept {name: "Robot_1"}),
  (n2:Concept {name: "Batteries"}),
  (n1)-[:EATS]->(n2);

// What eats batteries?
MATCH
  (n:Concept)-[:EATS]->(b:Concept {name: "Batteries"})
RETURN
  (n);

// ----- Example #2 -----
// An n-ary relation.

// Zeno gave Einstein a battery.
// gave(Zeno, Battery, Einstein)

// AtomSpace syntax:
// (EvaluationLink
//   (PredicateNode "gave")
//   (ListLink
//     (ConceptNode "Zeno")
//     (ConceptNode "Battery")
//     (ConceptNode "Einstein")))

CREATE
  (n1:Relation {type: "GivingEvent"}),
  (n2:Concept {name: "Zeno"}),
  (n3:Concept {name: "Battery"}),
  (n4:Concept {name: "Einstein"}),
  (n2)-[:GIVER]->(n1),
  (n3)-[:OBJECT]->(n1),
  (n4)-[:RECEIVER]->(n1);

// What has been given?
MATCH
  (n1:Relation {type: "GivingEvent"})<-[r]-(n2)
RETURN
  n1, r, n2;

// Did anyone give a battery to anyone else?
MATCH
  (n1:Relation {type: "GivingEvent"}),
  (n2:Concept)-[:GIVER]->(n1),
  (n3:Concept {name: "Battery"})-[:OBJECT]->(n1),
  (n4:Concept)-[:RECEIVER]->(n1)
RETURN
  n2, n4;
