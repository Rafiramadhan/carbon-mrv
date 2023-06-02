import React from "react";
import ReactDOM from "react-dom/client";
import { Switch } from 'react-router';
// import { BrowserRouter as Router, Route, Switch } from 'react-router';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { Dapp } from "./components/Dapp";
import { Monitoring } from "./components/Monitoring"

// We import bootstrap here, but you can remove if you want
import "bootstrap/dist/css/bootstrap.css";
import reactDom from "react-dom";
import App from "./App";

// This is the entry point of your application, but it just renders the Dapp
// react component. All of the logic is contained in it.

const root = ReactDOM.createRoot(document.getElementById("root"));

// reactDom.render(<App />, document.getElementById('root'));

root.render(
  <React.StrictMode>
    {/* <Dapp /> */}
    {/* <Monitoring /> */}
    <App/>
  </React.StrictMode>
);

// ReactDOM.render(
//   <Router>
//     <Route path="/monitoring" component={App}/>
//   </Router>
// )
// ReactDOM.render(
//   <Router>
//     {/* <Routes> */}
//       {/* <Route path="/" element={<Dapp />} /> */}
//       {/* <Switch> */}

//       <Route exact path="/" component={<Dapp />} />
//       <Route exact path="/monitoring" component={<Monitoring />} />
//       {/* </Switch> */}
//       {/* Other routes */}
//     {/* </Routes> */}
//   </Router>,
//   document.getElementById('root')
// );