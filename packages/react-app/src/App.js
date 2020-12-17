import React, { lazy, Suspense } from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import "./App.scss";

import Loading from "./components/Loading";

const SideBar = lazy(() => import("./components/SideBar"));
const Header = lazy(() => import("./components/Header"));
const ErrorBoundary = lazy(() => import("./components/ErrorBoundary"));
const Overview = lazy(() => import("./components/Overview"));
const ManageStake = lazy(() => import("./components/ManageStake"));
const Rewards = lazy(() => import("./components/Rewards"));

function App() {

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
                    <Overview />
                  </ErrorBoundary>
                )}
              />
              <Route
                path="/manage-stake"
                exact
                render={() => (
                  <ErrorBoundary>
                    <ManageStake />
                  </ErrorBoundary>
                )}
              />
              <Route
                path="/rewards"
                exact
                render={() => (
                  <ErrorBoundary>
                    <Rewards />
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
