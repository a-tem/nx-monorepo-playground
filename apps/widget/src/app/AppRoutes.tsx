import { lazy } from 'react';
import { RouteObject } from 'react-router-dom';
import AppLayout from '../AppLayout';

const Home = lazy(() => import('./pages/Home'));
const Settings = lazy(() => import('./pages/Settings'));

const routes: RouteObject[] = [
  {
    path: '/',
    element: <AppLayout />,
    children: [
      { index: true, element: <Home /> },
      { path: 'settings', element: <Settings /> },
    ],
  },
];

export default routes;
