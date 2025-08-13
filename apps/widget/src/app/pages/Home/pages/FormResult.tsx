import { Paper, Typography } from '@mui/material';
import React from 'react';
import { Link } from 'react-router-dom';

const FormResult: React.FC = () => {
  return (
    <Paper>
      <Typography variant="h4">Form Result</Typography>
      <Link to="/">Go to the Form page</Link>
      <Link to={`/form-processing/${crypto.randomUUID()}`}>
        Go back to the Form Result page
      </Link>
    </Paper>
  );
};

export default FormResult;
