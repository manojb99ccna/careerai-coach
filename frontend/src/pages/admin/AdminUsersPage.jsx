import { useEffect, useMemo, useState } from 'react'
import { adminApiClient } from '../../api/adminClient'

const apiBaseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000'

function AdminUsersPage() {
  const [q, setQ] = useState('')
  const [data, setData] = useState({ total: 0, users: [] })
  const [error, setError] = useState('')
  const [isLoading, setIsLoading] = useState(true)

  const [activeUser, setActiveUser] = useState(null)
  const [loginAttempts, setLoginAttempts] = useState([])
  const [progress, setProgress] = useState(null)
  const [selectedMilestoneId, setSelectedMilestoneId] = useState(null)
  const [modalError, setModalError] = useState('')
  const [isModalLoading, setIsModalLoading] = useState(false)
  const [activeTab, setActiveTab] = useState('progress') // 'login' | 'progress'

  const queryString = useMemo(() => {
    const params = new URLSearchParams()
    if (q.trim()) params.set('q', q.trim())
    params.set('skip', '0')
    params.set('limit', '50')
    return params.toString()
  }, [q])

  useEffect(() => {
    let cancelled = false
    const load = async () => {
      setIsLoading(true)
      setError('')
      try {
        const response = await adminApiClient.get(`/admin/users?${queryString}`)
        if (cancelled) return
        setData(response.data)
      } catch {
        if (cancelled) return
        setError('Failed to load users.')
      } finally {
        if (!cancelled) setIsLoading(false)
      }
    }
    load()
    return () => {
      cancelled = true
    }
  }, [queryString])

  const openUserModal = async (user) => {
    setActiveUser(user)
    setLoginAttempts([])
    setProgress(null)
    setModalError('')
    setIsModalLoading(true)
    try {
      const [attemptsRes, progressRes] = await Promise.all([
        adminApiClient.get(`/admin/users/${user.id}/login-attempts?limit=50`),
        adminApiClient.get(`/admin/users/${user.id}/progress`),
      ])
      setLoginAttempts(Array.isArray(attemptsRes.data) ? attemptsRes.data : [])
      setProgress(progressRes.data || null)
      const first = (progressRes.data?.milestones || [])[0]
      setSelectedMilestoneId(first ? first.master_milestone_id : null)
    } catch {
      setModalError('Failed to load user details.')
    } finally {
      setIsModalLoading(false)
    }
  }

  const closeModal = () => {
    setActiveUser(null)
    setLoginAttempts([])
    setProgress(null)
    setModalError('')
    setIsModalLoading(false)
  }

  return (
    <div className="container py-4">
      <div className="d-flex align-items-center justify-content-between gap-3 mb-3">
        <h1 className="h5 mb-0">Users</h1>
        <div className="d-flex align-items-center gap-2">
          <input
            className="form-control form-control-sm"
            placeholder="Search name/email/phone..."
            value={q}
            onChange={(e) => setQ(e.target.value)}
            style={{ width: '260px' }}
          />
        </div>
      </div>

      {isLoading && <div className="text-muted">Loading...</div>}
      {error && <div className="alert alert-danger py-2">{error}</div>}

      {!isLoading && !error && (
        <div className="card">
          <div className="card-body">
            <div className="small text-muted mb-2">Total: {data.total}</div>
            <div className="table-responsive">
              <table className="table table-sm align-middle">
                <thead>
                  <tr>
                    <th>User</th>
                    <th>Role</th>
                    <th>Joined</th>
                    <th>Plan</th>
                    <th>Milestones</th>
                    <th>Last Login</th>
                    <th />
                  </tr>
                </thead>
                <tbody>
                  {(data.users || []).map((u) => (
                    <tr key={u.id}>
                      <td>
                        <div className="d-flex align-items-center gap-2">
                          {u.profile_image ? (
                            <img
                              src={`${apiBaseUrl}/media/profile/${u.profile_image}`}
                              alt="Profile"
                              width="32"
                              height="32"
                              className="rounded-circle"
                              style={{ objectFit: 'cover' }}
                            />
                          ) : (
                            <div
                              className="rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center"
                              style={{ width: '32px', height: '32px', fontSize: '14px' }}
                            >
                              {u.name ? u.name.charAt(0).toUpperCase() : 'U'}
                            </div>
                          )}
                          <div>
                            <div className="fw-semibold">{u.name}</div>
                            <div className="small text-muted">{u.email}</div>
                          </div>
                        </div>
                      </td>
                      <td>
                        <div className="small">{u.role_name || '-'}</div>
                        <div className="small text-muted">{u.experience_level_name || ''}</div>
                      </td>
                      <td className="small">{u.created_at || '-'}</td>
                      <td className="small">{u.has_plan ? 'Yes' : 'No'}</td>
                      <td className="small">
                        {u.completed_milestones}/{u.total_milestones} (Current: {u.current_milestone_number || '-'})
                      </td>
                      <td className="small">{u.last_login_at || '-'}</td>
                      <td className="text-end">
                        <button type="button" className="btn btn-sm btn-outline-primary" onClick={() => openUserModal(u)}>
                          View
                        </button>
                      </td>
                    </tr>
                  ))}
                  {(data.users || []).length === 0 && (
                    <tr>
                      <td colSpan={7} className="text-center text-muted py-4">
                        No users found
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {activeUser && (
        <div
          className="modal show"
          tabIndex="-1"
          style={{ display: 'block', backgroundColor: 'rgba(0,0,0,0.45)' }}
          role="dialog"
          aria-modal="true"
        >
          <div
            className="modal-dialog modal-dialog-centered"
            style={{ maxWidth: '96vw', width: '96vw', height: '90vh', margin: '1.25rem auto' }}
          >
            <div className="modal-content" style={{ height: '100%' }}>
              <div className="modal-header">
                <div>
                  <div className="modal-title h6 mb-0">{activeUser.name}</div>
                  <div className="small text-muted">{activeUser.email}</div>
                </div>
                <button type="button" className="btn-close" onClick={closeModal} />
              </div>
              <div className="modal-body" style={{ overflow: 'auto' }}>
                {isModalLoading && <div className="text-muted">Loading...</div>}
                {modalError && <div className="alert alert-danger py-2">{modalError}</div>}

                {!isModalLoading && !modalError && (
                  <>
                    <ul className="nav nav-tabs mb-3">
                      <li className="nav-item">
                        <button
                          className={`nav-link ${activeTab === 'progress' ? 'active' : ''}`}
                          onClick={() => setActiveTab('progress')}
                        >
                          Progress Report
                        </button>
                      </li>
                      <li className="nav-item">
                        <button
                          className={`nav-link ${activeTab === 'login' ? 'active' : ''}`}
                          onClick={() => setActiveTab('login')}
                        >
                          Login History
                        </button>
                      </li>
                    </ul>

                    {activeTab === 'login' && (
                      <div className="card">
                        <div className="card-body">
                          <div className="fw-semibold mb-2">Login History</div>
                          <div className="table-responsive">
                            <table className="table table-sm align-middle mb-0">
                              <thead>
                                <tr>
                                  <th>Time</th>
                                  <th>Status</th>
                                  <th>Confidence</th>
                                  <th>Face</th>
                                  <th>IP / Device</th>
                                </tr>
                              </thead>
                              <tbody>
                                {loginAttempts.map((a) => (
                                  <tr key={a.id}>
                                    <td className="small">{a.created_at}</td>
                                    <td className="small">
                                      <span className={a.login_status === 'success' ? 'text-success' : 'text-danger'}>
                                        {a.login_status}
                                      </span>
                                    </td>
                                    <td className="small">{typeof a.confidence_score === 'number' ? a.confidence_score.toFixed(4) : '-'}</td>
                                    <td>
                                      {a.face_image_path ? (
                                        <img
                                          src={`${apiBaseUrl}/media/login_faces/${a.face_image_path}`}
                                          alt="Face"
                                          width="42"
                                          height="42"
                                          className="rounded"
                                          style={{ objectFit: 'cover' }}
                                        />
                                      ) : (
                                        <span className="small text-muted">-</span>
                                      )}
                                    </td>
                                    <td className="small">
                                      <div>{a.ip_address || '-'}</div>
                                      <div className="text-muted text-truncate" style={{ maxWidth: '420px' }}>
                                        {a.device_info || a.browser_info || '-'}
                                      </div>
                                    </td>
                                  </tr>
                                ))}
                                {loginAttempts.length === 0 && (
                                  <tr>
                                    <td colSpan={5} className="text-center text-muted py-3">
                                      No login attempts recorded
                                    </td>
                                  </tr>
                                )}
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                    )}

                    {activeTab === 'progress' && (
                      <div className="card">
                        <div className="card-body">
                          <div className="fw-semibold mb-2">Progress Report</div>
                          {!progress || !progress.milestones || progress.milestones.length === 0 ? (
                            <div className="text-muted">No training plan found.</div>
                          ) : (
                            <>
                              <div className="table-responsive">
                                <table className="table table-sm align-middle mb-0">
                                  <thead>
                                    <tr>
                                      <th>#</th>
                                      <th>Milestone</th>
                                      <th>Status</th>
                                      <th>Study</th>
                                      <th>Practice</th>
                                      <th>Quiz</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {progress.milestones.map((m) => (
                                      <tr
                                        key={m.master_milestone_id}
                                        onClick={() => setSelectedMilestoneId(m.master_milestone_id)}
                                        style={{ cursor: 'pointer' }}
                                        className={selectedMilestoneId === m.master_milestone_id ? 'table-active' : ''}
                                      >
                                        <td className="small">{m.milestone_number}</td>
                                        <td className="small">{m.title}</td>
                                        <td className="small">{m.status}</td>
                                        <td className="small">
                                          {m.study_materials_completed}/{m.study_materials_total}
                                        </td>
                                        <td className="small">{m.practice_completed ? 'Yes' : 'No'}</td>
                                        <td className="small">
                                          {m.last_quiz_score != null && m.last_quiz_total != null
                                            ? `${m.last_quiz_score}/${m.last_quiz_total} (${m.last_quiz_passed ? 'Pass' : 'Fail'})`
                                            : '-'}
                                        </td>
                                      </tr>
                                    ))}
                                  </tbody>
                                </table>
                              </div>
                              {(() => {
                                const m = (progress.milestones || []).find((x) => x.master_milestone_id === selectedMilestoneId)
                                if (!m) return null
                                return (
                                  <div className="mt-3">
                                    <div className="row g-3">
                                      <div className="col-12">
                                        <div className="small text-muted mb-2">
                                          Practice: {m.practice_completed ? 'Completed' : 'Not completed'}{' '}
                                          {m.practice_completed_at ? `at ${m.practice_completed_at}` : ''}
                                        </div>
                                      </div>
                                      <div className="col-lg-7">
                                        <div className="card">
                                          <div className="card-body">
                                            <div className="fw-semibold mb-2">Study Materials</div>
                                            <div className="table-responsive">
                                              <table className="table table-sm mb-0">
                                                <thead>
                                                  <tr>
                                                    <th>Title</th>
                                                    <th>Status</th>
                                                    <th>Completed At</th>
                                                  </tr>
                                                </thead>
                                                <tbody>
                                                  {(m.study_materials_detail || []).map((s) => (
                                                    <tr key={s.id}>
                                                      <td className="small">{s.title || '-'}</td>
                                                      <td className="small">{s.is_completed ? 'Done' : 'Pending'}</td>
                                                      <td className="small">{s.completed_at || '-'}</td>
                                                    </tr>
                                                  ))}
                                                  {(m.study_materials_detail || []).length === 0 && (
                                                    <tr>
                                                      <td colSpan={3} className="text-center text-muted py-2">
                                                        No items
                                                      </td>
                                                    </tr>
                                                  )}
                                                </tbody>
                                              </table>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                      <div className="col-lg-5">
                                        <div className="card">
                                          <div className="card-body">
                                            <div className="fw-semibold mb-2">Last Quiz Answers</div>
                                            {!m.last_quiz_detail ? (
                                              <div className="text-muted small">No quiz attempt.</div>
                                            ) : (
                                              <>
                                                <div className="small text-muted mb-2">
                                                  Attempted: {m.last_quiz_detail.attempted_at || '-'} | Score: {m.last_quiz_detail.score}/
                                                  {m.last_quiz_detail.total_questions} ({m.last_quiz_detail.passed ? 'Pass' : 'Fail'})
                                                </div>
                                                <div className="table-responsive">
                                                  <table className="table table-sm mb-0">
                                                    <thead>
                                                      <tr>
                                                        <th style={{ width: '45%' }}>Question</th>
                                                        <th style={{ width: '20%' }}>Selected</th>
                                                        <th style={{ width: '20%' }}>Correct</th>
                                                        <th style={{ width: '15%' }}>Result</th>
                                                      </tr>
                                                    </thead>
                                                    <tbody>
                                                      {(m.last_quiz_detail.answers || []).map((ans, idx) => (
                                                        <tr key={`${ans.question_id}-${idx}`}>
                                                          <td className="small">
                                                            <div className="mb-1">{ans.question_text || '-'}</div>
                                                            <div className="d-flex flex-wrap gap-1">
                                                              {(ans.options || []).map((optText, oi) => {
                                                                const key = String.fromCharCode(65 + oi)
                                                                const isSel = ans.selected_answer === key
                                                                const isCor = ans.correct_answer === key
                                                                let cls = 'badge bg-light text-dark'
                                                                if (isSel && isCor) cls = 'badge bg-success'
                                                                else if (isSel && !isCor) cls = 'badge bg-danger'
                                                                else if (isCor) cls = 'badge bg-success'
                                                                return (
                                                                  <span key={`${idx}-${oi}`} className={cls} style={{ whiteSpace: 'normal' }}>
                                                                    {key}. {optText}
                                                                  </span>
                                                                )
                                                              })}
                                                            </div>
                                                          </td>
                                                          <td className="small">{ans.selected_answer || '-'}</td>
                                                          <td className="small">{ans.correct_answer || '-'}</td>
                                                          <td className="small">
                                                            <span className={ans.is_correct ? 'text-success' : 'text-danger'}>
                                                              {ans.is_correct ? 'Correct' : 'Wrong'}
                                                            </span>
                                                          </td>
                                                        </tr>
                                                      ))}
                                                      {(m.last_quiz_detail.answers || []).length === 0 && (
                                                        <tr>
                                                          <td colSpan={4} className="text-center text-muted py-2">
                                                            No answers recorded
                                                          </td>
                                                        </tr>
                                                      )}
                                                    </tbody>
                                                  </table>
                                                </div>
                                              </>
                                            )}
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                )
                              })()}
                            </>
                          )}
                        </div>
                      </div>
                    )}
                  </>
                )}
              </div>
              <div className="modal-footer">
                <button type="button" className="btn btn-secondary" onClick={closeModal}>
                  Close
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

export default AdminUsersPage
