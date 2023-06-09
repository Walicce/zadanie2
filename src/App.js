import logo from './logo.svg';
import './App.css';
import React from 'react';
function App() {
  const fullName = 'Nadzeya Simakovich';
  
  
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        
        <p>
          Imię i nazwisko studenta: {fullName}
        </p>
        
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  
  );
}

export default App;
