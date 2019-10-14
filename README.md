# Example PoC for testing with mocks & stubs.

Testing things like TCPConnectionNotify implementations is hard because passing a TCPConnection into it introduces more failure modes.

Sample code that might be generated either at runtime or prior to test compile.

I want to generate this code because writing the interface & initial stub is painfully time consuming, error prone, and hard to maintain.

## Complications

### interface requirement

For a stub to be created, an interface needs to exist for the type that is being stubbed.

### capabilities

Care will be required when a parameter to a behaviour has the `iso` capability.

### ArgumentsN

I don't like the `Arguments2`, a tuple would be better, but for the PoC, it is good enough.

