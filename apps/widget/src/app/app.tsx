import styled from '@emotion/styled';
import { Title, Ui } from '@libs/ui';

// import { Route, Routes, Link } from 'react-router-dom';

const StyledApp = styled.div`
  // Your style here
`;

export function App() {
  return (
    <StyledApp>
      <Title title="Welcome to the Widget App!" />
      <Ui />
    </StyledApp>
  );
}

export default App;
