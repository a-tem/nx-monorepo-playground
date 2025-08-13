import { Box, Grid, Typography } from '@mui/material';
import React from 'react';
import { Outlet } from 'react-router-dom';

const Home: React.FC = () => {
  return (
    <Box>
      <Typography variant="h3">Home Page</Typography>
      <Grid container spacing={2}>
        <Grid size={8}>
          <Outlet />
        </Grid>
        <Grid size={4}>
          <Typography variant="body1">Static block</Typography>
        </Grid>
      </Grid>
    </Box>
  );
};

export default Home;
