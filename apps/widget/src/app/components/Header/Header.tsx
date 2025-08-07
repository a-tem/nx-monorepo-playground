import { AppBar, Box } from '@mui/material';
import { Toolbar } from '@mui/material';
import { Typography } from '@mui/material';

const Header = () => {
  return (
    <Box>
      <AppBar>
        <Toolbar>
          <Typography variant="h6">My App</Typography>
        </Toolbar>
      </AppBar>
    </Box>
  );
};

export default Header;
