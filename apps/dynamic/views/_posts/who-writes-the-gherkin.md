Rather than having product specialists write features in isolation, we have seen best success when the team work like this:

The Product Owner does some preparatory work to research the acceptance criteria and scope of the story
The three amigos (PO, QA and Dev) have a conversation, using a structure like https://cucumber.io/blog/2015/12/08/example-mapping-introduction to align their understanding about the details of the story
The Dev and QA document the outcome of that conversation as changes to their Gherkin features & scenarios
They feed back those new features to the PO for review
Once the PO is happy, they start coding, using the new scenarios to drive development
In this way, the features become a cheap simulation of the work the developers are about to do. By having the people with the least knowledge write the features, you get the best measure of the team's overall understanding of the work to be done. This gives you the best chance of catching mistakes and misunderstandings early, one of the main goals of BDD.
