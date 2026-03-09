import AdminSidebar from './AdminSidebar'
import AdminTopNavbar from './AdminTopNavbar'
import { Outlet } from 'react-router-dom'

function AdminLayout() {
  return (
    <div className="app-layout">
      <AdminSidebar />
      <div className="app-main">
        <AdminTopNavbar />
        <main className="app-content">
          <Outlet />
        </main>
      </div>
    </div>
  )
}

export default AdminLayout

