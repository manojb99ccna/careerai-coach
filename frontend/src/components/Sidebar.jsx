import { NavLink } from 'react-router-dom'

function Sidebar() {
  return (
    <div className="d-flex flex-column flex-shrink-0 bg-dark text-white vh-100 position-fixed sidebar">
      <div className="p-3 border-bottom border-secondary">
        <span className="fs-5 fw-semibold">CareerAI Coach</span>
      </div>
      <ul className="nav nav-pills flex-column mb-auto mt-3">
        <li className="nav-item">
          <NavLink to="/dashboard" className="nav-link text-white" activeclassname="active">
            Dashboard
          </NavLink>
        </li>
        <li className="nav-item">
          <NavLink to="/training" className="nav-link text-white" activeclassname="active">
            Training
          </NavLink>
        </li>
        <li className="nav-item">
          <NavLink to="/ai-feedback" className="nav-link text-white" activeclassname="active">
            AI Feedback
          </NavLink>
        </li>
        <li className="nav-item">
          <NavLink to="/resume-suggestions" className="nav-link text-white" activeclassname="active">
            Resume Suggestions
          </NavLink>
        </li>
      </ul>
    </div>
  )
}

export default Sidebar

