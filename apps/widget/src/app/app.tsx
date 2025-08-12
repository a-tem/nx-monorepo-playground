import styled from '@emotion/styled';
import { useRoutes } from 'react-router-dom';
import routes from './AppRoutes';

// import { Route, Routes, Link } from 'react-router-dom';

const StyledApp = styled.div`
  // Your style here
`;

export function App() {
  const element = useRoutes(routes);
  return <StyledApp>{element}</StyledApp>;
}

export default App;
