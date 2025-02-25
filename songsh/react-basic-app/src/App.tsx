import React from 'react';
import Component, {ClassComponent, FunctionalComponent} from './component/Component'
import './App.css';
import CurlyBraces from './component/CurlyBraces';
import Properties from './component-manage/Properties';

function App() {
  return (
    <div>
      {/* <ClassComponent />
      <FunctionalComponent />
      <Component /> */}
      {/* <CurlyBraces /> */}
      <Properties />
    </div>
  );
}

export default App;
