import styled from '@emotion/styled';
import { AppLayout } from '../AppLayout';

// import { Route, Routes, Link } from 'react-router-dom';

const StyledApp = styled.div`
  // Your style here
`;

export function App() {
  return (
    <StyledApp>
      <AppLayout>
        <div>App</div>
      </AppLayout>
    </StyledApp>
  );
}

export default App;
