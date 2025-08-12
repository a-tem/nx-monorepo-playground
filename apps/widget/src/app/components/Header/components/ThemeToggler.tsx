import React from 'react';
import { Stack, Switch } from '@mui/material';
import BedtimeIcon from '@mui/icons-material/Bedtime';
import LightModeIcon from '@mui/icons-material/LightMode';

const ThemeToggler: React.FC = () => {
  return (
    <Stack direction="row" alignItems="center">
      <BedtimeIcon />
      <Switch
        value={true}
        onChange={(e) => {
          console.log(e);
        }}
      />
      <LightModeIcon />
    </Stack>
  );
};

export default ThemeToggler;
