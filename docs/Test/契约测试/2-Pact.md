# Pact

### points

- Writer your API specifications ijn Swagger
- Store them in version control and give access to any providers/consumers for collaboration
- Validate the swagger specifications are correct with swagger-cli
- Write pact tests in unit-testing framework of your choice, using one of the many different language implementations of Pact
- Run the tests during CI to generate the contract
- Validate the generated pact contract ageinst the swagger specification duing CI
- If it passes, publish the pact contract to the pack broker, tag it with the branch name
- If it is part of a development/staging/produciton additionally tag it with an identifier
- Consumers can generate mock providers from the pact contract to use in integration / UI / e2e testing
- Providers can read from the pact broker and test that they meet consumer expecations, as pact will mock the clients requests specified in the contracts
- All participants can use the can-i-deploy tool at CI time,to check if its compatible with other consumer/providers in a specific environment

### progress

1. clone postgres docker images
2. create the docker-compose.yml to run the postgres

```
version: '2'

volumes:
  pact-server-db: {}

services:
  postgres:
    image: postgres:9.5.12
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=postgres
    volumes:
      - pact-server-db:/Users/toobeloong/project/pact/postgresql

```
3. clone [pact broker](https://github.com/DiUS/pact_broker-docker) and update docker-compose.yml to postgres service config
4. visit the http://localhost

### demo online
[pact-demo](https://github.com/shavo007/pact-demo)

### demo with mocha

package.json
```json
{
  "name": "democonsumer",
  "version": "1.0.0",
  "main": "index.js",
  "license": "MIT",
  "scripts": {
    "test": "rimraf pacts && NODE_ENV=test mocha",
    "publish": "node publishPact.js"
  },
  "dependencies": {
    "@pact-foundation/pact": "^9.9.12",
    "@pact-foundation/pact-node": "^10.9.0",
    "axios": "^0.19.2",
    "chai": "^4.2.0",
    "mocha": "^7.1.1",
    "rimraf": "^3.0.2"
  }
}
```

publishPact.js
```javascript
const path = require('path');
let pact = require('@pact-foundation/pact-node');
var opts = {
    pactFilesOrDirs: [path.resolve(process.cwd(), 'pacts')],
    pactBroker: 'http://localhost',
    consumerVersion: '1.0.0',
    pactBrokerUsername: 'toobe',
    pactBrokerPassword: 'password',
    providerBaseUrl: 'http://localhost'
};

pact.publishPacts(opts).then(function () {
    console.log('Pacts published to broker');
});
```

test/provider.pact.spec.js
```javascript
const expect = require('chai').expect
const path = require('path')
const chai = require('chai')
const { Pact } = require('@pact-foundation/pact')
const axios = require('axios')

describe('The Demo API', () => {
  let url = 'http://localhost'
  const port = 1111

  const provider =  new Pact({
    port: port,
    log: path.resolve(process.cwd(), 'logs', 'mockserver-integration.log'),
    dir: path.resolve(process.cwd(), 'pacts'),
    spec: 2,
    consumer: 'DemoConsumer',
    provider: 'provider'
  })

  before(async function()  {
       this.timeout(10000) // it takes time to start the mock server
      await provider.setup()

  })

  after(async function() {
      this.timeout(10000) // it takes time to stop the mock server and gather the contracts
      await provider.finalize()
  })

  describe('get /demo', () => {
    before(done => {
      const interaction = {
          uponReceiving: 'a demo',
          withRequest: {
              method: 'GET',
              path: '/demo'
          },
          willRespondWith: {
              status: 200,
              headers: {
                  "Content-Type": "application/json"
              },
              body: {
                  name: 'toobe',
                  age: 'male'
              }
          }
      }
       provider.addInteraction(interaction).then(() => {
        done()
      })
    })

    afterEach(() => provider.verify())

    it("should return message",  function(done)   {
        sendDemoRequest().then(function(resp) {
            expect(resp.data).to.deep.equal({name: "toobe", age: "male"});
            done()
        })
    });
  })
})

function sendDemoRequest() {
    return axios.request({
      method: 'GET',
      baseURL: 'http://localhost:1111',
      url: '/demo' ,
      headers: { 'Accept': 'application/json' }
    })
}
```

```
yarn
yarn run test
yarn publish
```