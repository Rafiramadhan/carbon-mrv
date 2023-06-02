import React from "react";
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Routes,
} from "react-router-dom";
import Dapp from "./components/Dapp";
import Monitoring from "./components/Monitoring";
import Reporting from "./components/Reporting";

function App() {
  return (
    <Router>
      {/* <Switch> */}
      {/* <Routes> */}
      {/* <Route exact path="/" component={Dapp} /> */}
      {/* <Dapp /> */}
      {/* <Monitoring /> */}
      <Reporting />
      {/* <Route path="/monitoring" component={Monitoring} /> */}
      {/* </Routes> */}
      {/* </Switch> */}
    </Router>
  );
}

export default App;
