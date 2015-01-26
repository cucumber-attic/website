---
layout: one-column
---

## The Cucumber Pro results protocol

Cucumber Pro receives results over a WebSocket connection. The protocol is designed
to be agnostic about Cucumber. Think of it as a way to attach metadata to a line
in a file in a repo - for a particular revision.

There are currently 2 implementations:

* [cucumber-pro-ruby](https://github.com/cucumber-ltd/cucumber-pro-ruby)
* [cucumber-pro-jvm](https://github.com/cucumber-ltd/cucumber-pro-jvm)

### Establish a connection

To establish a connection you need the auth token for a Cucumber Pro user. We have
a test user that can be used to store results for open source projects. The connection URL is:

```
wss://results.cucumber.pro/ws?token=dbe1d91b213836a5966a877aceb63b04
```

In practice you'd use your own personal Cucumber Pro token.

### Initiate the session

After a connection has been established, send a header message to identify the repository,
revision and branch. The `group` property is a unique ID - typically a random hex string.

```json
{
  "repo_url": "https://github.com/foo/bar.git",
  "rev": "560fc319ca77deaa2eea6bfa3d82a6f17ae924b3",
  "branch": "master",
  "group": "4e590fc71cbe2395b7a492a7e8244050ea76f9f6",
  "info": {
    "os": "Linux 3.13.0-29-generic (amd64)",
    "os_user": "ubuntu",
    "client_version": "cucumber-pro-jvm 1.0.9",
    "tool_version": "cucumber-jvm 1.1.8",
    "platform_version": "Java 1.7.0_55 (Oracle Corporation)",
  }
}
```

The `info` property holds information about the machine. Here is an example:

### Store results

As mentioned above, results are just a tuple `path, location, mime_type, body`.

Example:

```json
{
  "path": "hello/world.feature",
  "location": 2,
  "mime_type": "application/vnd.cucumber.test-case-result+json",
  "body": {
    "status": "passed"
  }
}
```

The `path` field is the path from the root of the repository.
The `location` filed is just the 1-indexed line number.
The Cucumber-specific parts here is the `mime_type` and the `body`. The `status` property in `body` can be one of
`passed, skipped, pending, undefined, failed`.

Behat has the concept of "suites", which means a scenario can be run several times in the same run,
but in a different configuration, for example running via "ui" or "domain". This can be stored in
the `body` field as `suite`.

Later, if we want to store e.g. Robot framework results we'd define a new mime type and possibly a different
body schema.

### Replies

For each message sent by the client to the server, the server will send one back to the client.
The client can send messages back-to-back - it doesn't have to wait for an ack message before sending a
new message.

The client should however look at each received message and if it has an `error` property, throw
an exception using that property's value as the error message. This is important so that the
client fails if something went wrong on the server.

The client should hang around until it has received as many messages as it has received.

### Screenshots and blobs

The protocol for storing metadata where the body is a blob (such as an image) is
to send two messages where the first one is a regular metadata JSON message
*without* the body field set.

When the `body` field is not set, Cucumber Pro's results service expects the next message
to be a *binary* message.

### Closing the connection

When the client has sent all the results, just close the connection.

### Getting the data out

TBA - we haven't finalised this API yet - currently only the Cucumber Pro webapp knows
how to do this.
