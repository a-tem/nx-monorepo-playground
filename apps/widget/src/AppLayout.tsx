import React from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import { Container, ThemeProvider, createTheme } from '@mui/material';
import Header from './app/components/Header';
import { detectTheme } from './services/themeDetection';

const theme = createTheme({
  palette: {
    mode: detectTheme(),
  },
});

export const AppLayout: React.FC<React.PropsWithChildren> = ({ children }) => {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Header />
      <Container sx={{ mt: 2 }}>{children}</Container>
    </ThemeProvider>
  );
};

export default AppLayout;
