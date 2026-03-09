import { Navigate, Outlet, useLocation } from 'react-router-dom'

function AdminProtectedRoute() {
  const location = useLocation()
  const token = localStorage.getItem('careerai_admin_token')

  if (!token) {
    const path = location.pathname || ''
    if (path !== '/admin' && path !== '/admin/') {
      return <Navigate to="/admin" replace />
    }
    return <Outlet />
  }

  return <Outlet />
}

export default AdminProtectedRoute
