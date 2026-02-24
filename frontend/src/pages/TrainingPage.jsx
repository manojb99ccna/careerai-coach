import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { apiClient } from '../api/client'

function TrainingPage() {
  const navigate = useNavigate()
  const [isLoadingPlan, setIsLoadingPlan] = useState(true)
  const [planError, setPlanError] = useState('')
  const [hasPlan, setHasPlan] = useState(false)
  const [plan, setPlan] = useState(null)

  const [roles, setRoles] = useState([])
  const [experienceLevels, setExperienceLevels] = useState([])
  const [roleId, setRoleId] = useState('')
  const [experienceLevelId, setExperienceLevelId] = useState('')
  const [skills, setSkills] = useState('')
  const [isLoadingOptions, setIsLoadingOptions] = useState(false)
  const [optionsError, setOptionsError] = useState('')
  const [isGenerating, setIsGenerating] = useState(false)
  const [generateError, setGenerateError] = useState('')

  useEffect(() => {
    let cancelled = false

    async function loadPlan() {
      setIsLoadingPlan(true)
      setPlanError('')
      try {
        const response = await apiClient.get('/training/plan')
        if (cancelled) {
          return
        }

        const data = response.data
        if (data && data.has_plan && data.plan) {
          setHasPlan(true)
          setPlan(data.plan)
        } else {
          setHasPlan(false)
          setPlan(null)
        }
      } catch (error) {
        if (cancelled) {
          return
        }
        if (error.response && error.response.status === 401) {
          setPlanError('Please log in again to access your training plan.')
          setTimeout(() => {
            localStorage.removeItem('careerai_token')
            localStorage.removeItem('careerai_user')
            localStorage.removeItem('careerai_onboarding_complete')
            localStorage.removeItem('careerai_onboarding_answers')
            navigate('/')
          }, 2000)
        } else {
          setPlanError('Unable to load training plan right now.')
        }
        setHasPlan(false)
        setPlan(null)
      } finally {
        if (!cancelled) {
          setIsLoadingPlan(false)
        }
      }
    }

    loadPlan()

    return () => {
      cancelled = true
    }
  }, [])

  useEffect(() => {
    if (hasPlan || isLoadingPlan) {
      return
    }

    let cancelled = false

    async function loadOptionsAndOnboarding() {
      setIsLoadingOptions(true)
      setOptionsError('')
      try {
        const [rolesResponse, experienceResponse] = await Promise.all([
          apiClient.get('/meta/roles'),
          apiClient.get('/meta/experience-levels'),
        ])

        if (cancelled) {
          return
        }

        const fetchedRoles = Array.isArray(rolesResponse.data) ? rolesResponse.data : []
        const fetchedExperience = Array.isArray(experienceResponse.data) ? experienceResponse.data : []

        if (fetchedRoles.length > 0) {
          setRoles(fetchedRoles)
        } else {
          setRoles([
            { id: 'software-developer', name: 'Software Developer' },
            { id: 'frontend-developer', name: 'Frontend Developer' },
            { id: 'backend-developer', name: 'Backend Developer' },
            { id: 'data-analyst', name: 'Data Analyst' },
            { id: 'data-scientist', name: 'Data Scientist' },
          ])
        }

        if (fetchedExperience.length > 0) {
          setExperienceLevels(fetchedExperience)
        } else {
          setExperienceLevels([
            { id: 'fresher', name: 'Fresher (0–1 year)' },
            { id: 'junior', name: 'Junior (1–3 years)' },
            { id: 'mid-level', name: 'Mid-level (3–5 years)' },
            { id: 'senior', name: 'Senior (5+ years)' },
          ])
        }
      } catch {
        if (!cancelled) {
          setOptionsError('Using default options while loading choices from server.')
          setRoles([
            { id: 'software-developer', name: 'Software Developer' },
            { id: 'frontend-developer', name: 'Frontend Developer' },
            { id: 'backend-developer', name: 'Backend Developer' },
            { id: 'data-analyst', name: 'Data Analyst' },
            { id: 'data-scientist', name: 'Data Scientist' },
          ])
          setExperienceLevels([
            { id: 'fresher', name: 'Fresher (0–1 year)' },
            { id: 'junior', name: 'Junior (1–3 years)' },
            { id: 'mid-level', name: 'Mid-level (3–5 years)' },
            { id: 'senior', name: 'Senior (5+ years)' },
          ])
        }
      } finally {
        if (!cancelled) {
          setIsLoadingOptions(false)
        }
      }

      const storedUser = localStorage.getItem('careerai_user')
      if (!storedUser) {
        return
      }

      let userId = null
      try {
        const parsed = JSON.parse(storedUser)
        userId = parsed && parsed.id
      } catch {
        userId = null
      }

      if (!userId) {
        return
      }

      try {
        const response = await apiClient.get(`/users/${userId}/onboarding`)
        if (cancelled) {
          return
        }

        const data = response.data
        if (data) {
          if (data.role_id) {
            setRoleId(String(data.role_id))
          }
          if (data.experience_level_id) {
            setExperienceLevelId(String(data.experience_level_id))
          }
          if (typeof data.skills === 'string') {
            setSkills(data.skills)
          }
        }
      } catch {
        // ignore onboarding load issues in training page
      }
    }

    loadOptionsAndOnboarding()

    return () => {
      cancelled = true
    }
  }, [hasPlan, isLoadingPlan])

  const handleGenerate = async (event) => {
    event.preventDefault()
    setGenerateError('')

    if (!roleId || !experienceLevelId || !skills.trim()) {
      setGenerateError('Please select role, experience level, and enter your skills.')
      return
    }

    setIsGenerating(true)
    try {
      const response = await apiClient.post('/training/plan/generate', {
        role_id: Number(roleId),
        experience_level_id: Number(experienceLevelId),
        skills,
      })

      const data = response.data
      if (data && data.has_plan && data.plan) {
        setHasPlan(true)
        setPlan(data.plan)
      } else {
        setGenerateError('Training plan was not generated correctly. Please try again.')
      }
    } catch (error) {
      if (error.response && error.response.status === 401) {
        setGenerateError('Your session has expired. Please log in again and retry.')
      } else {
        setGenerateError('There was a problem generating your training plan. Please try again.')
      }
    } finally {
      setIsGenerating(false)
    }
  }

  const renderPlanView = () => {
    if (!plan) {
      return null
    }

    return (
      <div className="card shadow-sm">
        <div className="card-body">
          <h1 className="h5 mb-3">{plan.title || 'Your Training Plan'}</h1>
          {plan.description && <p className="text-muted mb-4">{plan.description}</p>}

          <h2 className="h6 mb-3">Milestones</h2>
          {Array.isArray(plan.milestones) && plan.milestones.length > 0 ? (
            <ul className="list-group list-group-flush">
              {plan.milestones.map((milestone) => {
                let badgeClass = 'bg-secondary'
                let statusLabel = 'Locked'
                if (milestone.status === 'completed') {
                  badgeClass = 'bg-success'
                  statusLabel = 'Completed'
                } else if (milestone.status === 'in_progress') {
                  badgeClass = 'bg-primary'
                  statusLabel = 'In Progress'
                }

                return (
                  <li
                    key={milestone.id}
                    className={`list-group-item d-flex justify-content-between align-items-start list-group-item-action ${milestone.status === 'locked' ? 'bg-light text-muted' : ''}`}
                    style={{ cursor: milestone.status === 'locked' ? 'not-allowed' : 'pointer' }}
                    onClick={() => {
                      if (milestone.status !== 'locked') {
                        navigate(`/training/milestones/${milestone.id}`)
                      }
                    }}
                  >
                    <div className="me-3">
                      <div className="fw-semibold">
                        {milestone.milestone_number}. {milestone.title}
                        {milestone.status === 'locked' && <i className="bi bi-lock-fill ms-2"></i>}
                      </div>
                      {milestone.description && (
                        <div className="text-muted small mt-1">{milestone.description}</div>
                      )}
                      <div className="small text-muted mt-1">
                        Estimated {milestone.estimated_days} days
                      </div>
                    </div>
                    <span className={`badge ${badgeClass} ms-2`}>{statusLabel}</span>
                  </li>
                )
              })}
            </ul>
          ) : (
            <p className="text-muted mb-0">No milestones found for this training plan.</p>
          )}
        </div>
      </div>
    )
  }

  const renderFormView = () => (
    <div className="card shadow-sm">
      <div className="card-body">
        <h1 className="h5 mb-3">Training Plan Setup</h1>
        <p className="text-muted mb-4">
          Tell CareerAI about your target role so it can generate a personalized milestone-based training plan.
        </p>
        {optionsError && <div className="alert alert-warning py-2">{optionsError}</div>}
        {generateError && <div className="alert alert-danger py-2">{generateError}</div>}
        <form onSubmit={handleGenerate}>
          <div className="mb-3">
            <label className="form-label">What field or role are you preparing for?</label>
            <select
              className="form-select"
              value={roleId}
              onChange={(event) => setRoleId(event.target.value)}
              required
              disabled={isLoadingOptions || roles.length === 0 || isGenerating}
            >
              <option value="">
                {isLoadingOptions ? 'Loading roles...' : 'Select a role'}
              </option>
              {roles.map((option) => (
                <option key={option.id || option.name} value={option.id}>
                  {option.name}
                </option>
              ))}
            </select>
          </div>
          <div className="mb-3">
            <label className="form-label">What is your current experience level?</label>
            <select
              className="form-select"
              value={experienceLevelId}
              onChange={(event) => setExperienceLevelId(event.target.value)}
              required
              disabled={isLoadingOptions || experienceLevels.length === 0 || isGenerating}
            >
              <option value="">
                {isLoadingOptions ? 'Loading experience levels...' : 'Select experience level'}
              </option>
              {experienceLevels.map((option) => (
                <option key={option.id || option.name} value={option.id}>
                  {option.name}
                </option>
              ))}
            </select>
          </div>
          <div className="mb-4">
            <label className="form-label">What are your current skills?</label>
            <input
              type="text"
              className="form-control"
              placeholder="For example: Python, React, SQL, HTML, CSS"
              value={skills}
              onChange={(event) => setSkills(event.target.value)}
              required
              disabled={isGenerating}
            />
          </div>
          <button type="submit" className="btn btn-primary" disabled={isGenerating}>
            {isGenerating ? 'Generating Training Plan...' : 'Generate Training Plan'}
          </button>
        </form>
      </div>
    </div>
  )

  return (
    <div className="container py-4">
      <div className="row justify-content-center">
        <div className="col-lg-8">
          {isLoadingPlan ? (
            <div className="card shadow-sm">
              <div className="card-body">
                <h1 className="h5 mb-3">Training</h1>
                <p className="text-muted mb-0">Loading your training plan...</p>
              </div>
            </div>
          ) : hasPlan ? (
            <>
              {planError && <div className="alert alert-danger mb-3">{planError}</div>}
              {renderPlanView()}
            </>
          ) : (
            <>
              {planError && <div className="alert alert-danger mb-3">{planError}</div>}
              {renderFormView()}
            </>
          )}
        </div>
      </div>
    </div>
  )
}

export default TrainingPage
