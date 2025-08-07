import React from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import { ThemeProvider, createTheme } from '@mui/material';
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
      {children}
    </ThemeProvider>
  );
};

export default AppLayout;
