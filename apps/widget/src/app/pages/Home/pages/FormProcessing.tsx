import { Paper, Typography } from '@mui/material';
import React from 'react';
import { Link } from 'react-router-dom';

const FormProcessing: React.FC = () => {
  return (
    <Paper>
      <Typography variant="h4">Form Processing</Typography>
      <Link to="/">Go back to the Form page</Link>
      <Link to={`/form-result/${crypto.randomUUID()}`}>
        Go to the Form Result page
      </Link>
    </Paper>
  );
};

export default FormProcessing;
