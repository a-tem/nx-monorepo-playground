import { Paper, Typography } from '@mui/material';
import React from 'react';
import { Link } from 'react-router-dom';

const Form: React.FC = () => {
  return (
    <Paper>
      <Typography variant="h4">Form</Typography>
      <Link to={`/form-processing/${crypto.randomUUID()}`}>
        Go to the Form Processing page
      </Link>
    </Paper>
  );
};

export default Form;
