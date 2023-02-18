import React from "react";

import { Route, Switch } from "react-router-dom";

import Dashboard from "../pages/Dashboard";
import Customers from "../pages/Users";
import Devices from "../pages/Devices";
import Login from "../pages/Login";

import CustomerDetail from "../pages/UserDetail";

const Routes = () => {
  return (
    <Switch>
      <Route path="/" exact component={Dashboard} />
      <Route path="/customers" component={Customers} />
      <Route path="/customer/:id" component={CustomerDetail} />
      <Route path="/devices" component={Devices} />

    </Switch>
  );
};

export default Routes;
