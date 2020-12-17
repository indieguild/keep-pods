import React, { lazy, Suspense, useCallback, useState, useEffect } from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import "./App.scss";

import Loading from "./components/Loading";
import useWeb3Modal from "./hooks/useWeb3Modal";
import { getKeepContract, getRegistryContract } from "./services/web3Services";

const SideBar = lazy(() => import("./components/SideBar"));
const Header = lazy(() => import("./components/Header"));
const ErrorBoundary = lazy(() => import("./components/ErrorBoundary"));
const Overview = lazy(() => import("./components/Overview"));
const ManageStake = lazy(() => import("./components/ManageStake"));
const Rewards = lazy(() => import("./components/Rewards"));

function App() {
  const [registryContractInstance, setRegistryContractInstance] = useState(
    null
  );
  const [keepContractInstance, setKeepContractInstance] = useState(null);

  const { provider } = useWeb3Modal();

  const getContractInstances = useCallback(async () => {
    if (provider) {
      const registryContract = await getRegistryContract(provider);
      const keepContract = await getKeepContract(provider);

      setRegistryContractInstance(registryContract);
      setKeepContractInstance(keepContract);
    }
  }, [provider]);

  useEffect(() => {
    getContractInstances();
  }, [getContractInstances]);

  return (
    <div className="App">
      <Suspense fallback={<Loading />}>
        <SideBar />
        <div className="app-main">
          <Header />
          <div className="home-container">
            <Switch>
              <Route
                path="/overview"
                exact
                render={() => (
                  <ErrorBoundary>
                    <Overview
                      registryContractInstance={registryContractInstance}
                      keepContractInstance={keepContractInstance}
                    />
                  </ErrorBoundary>
                )}
              />
              <Route
                path="/manage-stake"
                exact
                render={() => (
                  <ErrorBoundary>
                    <ManageStake
                      registryContractInstance={registryContractInstance}
                      keepContractInstance={keepContractInstance}
                    />
                  </ErrorBoundary>
                )}
              />
              <Route
                path="/rewards"
                exact
                render={() => (
                  <ErrorBoundary>
                    <Rewards
                      registryContractInstance={registryContractInstance}
                      keepContractInstance={keepContractInstance}
                    />
                  </ErrorBoundary>
                )}
              />
              <Route exact path="/">
                <Redirect to="/overview" />
              </Route>
            </Switch>
          </div>
        </div>
      </Suspense>
    </div>
  );
}

export default App;
