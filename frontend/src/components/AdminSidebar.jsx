import { NavLink } from 'react-router-dom'

function AdminSidebar() {
  return (
    <div className="d-flex flex-column flex-shrink-0 bg-dark text-white vh-100 position-fixed sidebar">
      <div className="p-3 border-bottom border-secondary">
        <span className="fs-5 fw-semibold">CareerAI Admin</span>
      </div>
      <ul className="nav nav-pills flex-column mb-auto mt-3">
        <li className="nav-item">
          <NavLink to="/admin/dashboard" className="nav-link text-white" activeclassname="active">
            Dashboard
          </NavLink>
        </li>
        <li className="nav-item">
          <NavLink to="/admin/users" className="nav-link text-white" activeclassname="active">
            Users
          </NavLink>
        </li>
        <li className="nav-item">
          <NavLink to="/admin/master-data" className="nav-link text-white" activeclassname="active">
            Master Data
          </NavLink>
        </li>
        <li className="nav-item">
          <NavLink to="/admin/settings" className="nav-link text-white" activeclassname="active">
            Settings
          </NavLink>
        </li>
      </ul>
    </div>
  )
}

export default AdminSidebar

