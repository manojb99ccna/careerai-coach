import { useEffect, useState } from 'react'
import { adminApiClient } from '../../api/adminClient'

function AdminSettingsPage() {
  const [settings, setSettings] = useState(null)
  const [quizTotal, setQuizTotal] = useState('')
  const [practiceTotal, setPracticeTotal] = useState('')
  const [isActive, setIsActive] = useState(true)
  const [error, setError] = useState('')
  const [isLoading, setIsLoading] = useState(true)
  const [isSaving, setIsSaving] = useState(false)
  const [success, setSuccess] = useState('')

  useEffect(() => {
    let cancelled = false
    const load = async () => {
      setIsLoading(true)
      setError('')
      try {
        const response = await adminApiClient.get('/admin/settings/milestone')
        if (cancelled) return
        setSettings(response.data)
        setQuizTotal(String(response.data.quiz_questions_total ?? ''))
        setPracticeTotal(String(response.data.practice_questions_total ?? ''))
        setIsActive(Boolean(response.data.is_active))
      } catch {
        if (cancelled) return
        setError('Failed to load settings.')
      } finally {
        if (!cancelled) setIsLoading(false)
      }
    }
    load()
    return () => {
      cancelled = true
    }
  }, [])

  const save = async () => {
    if (!settings) return
    setIsSaving(true)
    setError('')
    setSuccess('')
    try {
      const payload = {
        quiz_questions_total: Number(quizTotal),
        practice_questions_total: Number(practiceTotal),
        is_active: Boolean(isActive),
      }
      const response = await adminApiClient.put(`/admin/settings/milestone/${settings.id}`, payload)
      setSettings(response.data)
      setSuccess('Updated successfully.')
      setTimeout(() => setSuccess(''), 2500)
    } catch {
      setError('Failed to save settings.')
    } finally {
      setIsSaving(false)
    }
  }

  return (
    <div className="container py-4">
      <h1 className="h5 mb-3">Settings</h1>
      {isLoading && <div className="text-muted">Loading...</div>}
      {error && <div className="alert alert-danger py-2">{error}</div>}
      {success && <div className="alert alert-success py-2">{success}</div>}

      {!isLoading && settings && (
        <div className="card">
          <div className="card-body">
            <div className="fw-semibold mb-3">Milestone Settings</div>

            <div className="row g-3">
              <div className="col-md-4">
                <label className="form-label">Quiz Questions Total</label>
                <input
                  type="number"
                  className="form-control"
                  value={quizTotal}
                  onChange={(e) => setQuizTotal(e.target.value)}
                  min="1"
                />
              </div>

              <div className="col-md-4">
                <label className="form-label">Practice Questions Total</label>
                <input
                  type="number"
                  className="form-control"
                  value={practiceTotal}
                  onChange={(e) => setPracticeTotal(e.target.value)}
                  min="0"
                />
              </div>

              <div className="col-md-4 d-flex align-items-end">
                <div className="form-check">
                  <input
                    className="form-check-input"
                    type="checkbox"
                    checked={isActive}
                    onChange={(e) => setIsActive(e.target.checked)}
                    id="milestoneSettingsActive"
                  />
                  <label className="form-check-label" htmlFor="milestoneSettingsActive">
                    Active
                  </label>
                </div>
              </div>
            </div>

            <div className="mt-4">
              <button type="button" className="btn btn-primary" onClick={save} disabled={isSaving}>
                {isSaving ? 'Saving...' : 'Save'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

export default AdminSettingsPage
