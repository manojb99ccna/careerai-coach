import { useEffect, useState } from 'react'
import { adminApiClient } from '../../api/adminClient'

function AdminDashboardPage() {
  const [summary, setSummary] = useState(null)
  const [error, setError] = useState('')
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    let cancelled = false
    const load = async () => {
      setIsLoading(true)
      setError('')
      try {
        const response = await adminApiClient.get('/admin/dashboard/summary?days=14')
        if (cancelled) return
        setSummary(response.data)
      } catch {
        if (cancelled) return
        setError('Failed to load dashboard data.')
      } finally {
        if (!cancelled) setIsLoading(false)
      }
    }
    load()
    return () => {
      cancelled = true
    }
  }, [])

  return (
    <div className="container py-4">
      <h1 className="h5 mb-3">Admin Dashboard</h1>
      {isLoading && <div className="text-muted">Loading...</div>}
      {error && <div className="alert alert-danger py-2">{error}</div>}
      {summary && (
        <div className="row g-3">
          <div className="col-md-3">
            <div className="card">
              <div className="card-body">
                <div className="text-muted small">Total Users</div>
                <div className="fs-4 fw-semibold">{summary.total_users}</div>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <div className="card">
              <div className="card-body">
                <div className="text-muted small">Training Plans</div>
                <div className="fs-4 fw-semibold">{summary.total_training_plans}</div>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <div className="card">
              <div className="card-body">
                <div className="text-muted small">Active User Plans</div>
                <div className="fs-4 fw-semibold">{summary.active_user_plans}</div>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <div className="card">
              <div className="card-body">
                <div className="text-muted small">Completed Milestones</div>
                <div className="fs-4 fw-semibold">{summary.completed_milestones}</div>
              </div>
            </div>
          </div>

          <div className="col-12">
            <div className="card">
              <div className="card-body">
                <div className="fw-semibold mb-2">Registrations (last 14 days)</div>
                <div className="table-responsive">
                  <table className="table table-sm mb-0">
                    <thead>
                      <tr>
                        <th>Date</th>
                        <th>Count</th>
                      </tr>
                    </thead>
                    <tbody>
                      {(summary.registrations_by_day || []).map((row) => (
                        <tr key={row.date}>
                          <td>{row.date}</td>
                          <td>{row.count}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>

          <div className="col-12">
            <div className="card">
              <div className="card-body">
                <div className="fw-semibold mb-2">Successful Logins (last 14 days)</div>
                <div className="table-responsive">
                  <table className="table table-sm mb-0">
                    <thead>
                      <tr>
                        <th>Date</th>
                        <th>Count</th>
                      </tr>
                    </thead>
                    <tbody>
                      {(summary.logins_by_day || []).map((row) => (
                        <tr key={row.date}>
                          <td>{row.date}</td>
                          <td>{row.count}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

export default AdminDashboardPage

