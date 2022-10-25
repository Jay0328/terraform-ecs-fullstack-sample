import { useEffect, useState } from 'react';
import { environment } from '../environments';
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import styles from './App.module.scss';

export function App() {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch(`${environment.apiUrl}/api`)
      .then((response) => response.json())
      .then((data) => setMessage(data.message))
      .catch((error) => console.error(error));
  }, []);

  return (
    <div>
      client!!
      <br />
      {message}
    </div>
  );
}

export default App;
