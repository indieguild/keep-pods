import React, { lazy, Suspense } from "react";
import { Route, Switch, Redirect } from "react-router-dom";
import "./App.scss";

import Loading from "./components/Loading";

const SideBar = lazy(() => import("./components/SideBar"));
const Header = lazy(() => import("./components/Header"));
const Overview = lazy(() => import("./components/Overview"));
const ErrorBoundary = lazy(() => import("./components/ErrorBoundary"));

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
