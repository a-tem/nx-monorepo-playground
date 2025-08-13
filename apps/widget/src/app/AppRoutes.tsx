import { lazy } from 'react';
import { RouteObject } from 'react-router-dom';
import AppLayout from '../AppLayout';

const Home = lazy(() => import('./pages/Home'));
const Settings = lazy(() => import('./pages/Settings'));
const Form = lazy(() => import('./pages/Home/pages/Form'));
const FormProcessing = lazy(() => import('./pages/Home/pages/FormProcessing'));
const FormResult = lazy(() => import('./pages/Home/pages/FormResult'));

const routes: RouteObject[] = [
  {
    path: '/',
    element: <AppLayout />,
    children: [
      {
        path: '/',
        element: <Home />,
        children: [
          { index: true, element: <Form /> },
          { path: 'form-processing/:id', element: <FormProcessing /> },
          { path: 'form-result/:id', element: <FormResult /> },
        ],
      },
      { path: 'settings', element: <Settings /> },
    ],
  },
];

export default routes;
