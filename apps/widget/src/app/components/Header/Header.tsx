import { AppBar, Stack } from '@mui/material';
import { Toolbar } from '@mui/material';
import { Typography } from '@mui/material';
import ThemeToggler from './components/ThemeToggler';

const Header = () => {
  return (
    <AppBar position="static">
      <Toolbar>
        <Stack
          direction="row"
          justifyContent="space-between"
          alignItems="center"
          width="100%"
          gap={2}
        >
          <Typography variant="h6">My App</Typography>
          <ThemeToggler />
        </Stack>
      </Toolbar>
    </AppBar>
  );
};

export default Header;
