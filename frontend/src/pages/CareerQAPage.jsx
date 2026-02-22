import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { apiClient } from '../api/client'

function CareerQAPage() {
  const navigate = useNavigate()
  const [roles, setRoles] = useState([])
  const [experienceLevels, setExperienceLevels] = useState([])
  const [roleId, setRoleId] = useState('')
  const [experienceLevelId, setExperienceLevelId] = useState('')
  const [skills, setSkills] = useState('')
  const [resume, setResume] = useState(null)
  const [isLoadingOptions, setIsLoadingOptions] = useState(true)
  const [optionsError, setOptionsError] = useState('')

  useEffect(() => {
    let cancelled = false

    async function loadOptions() {
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
    }

    loadOptions()

    return () => {
      cancelled = true
    }
  }, [])

  const handleSubmit = async (event) => {
    event.preventDefault()

    const storedUser = localStorage.getItem('careerai_user')
    if (!storedUser) {
      navigate('/')
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
      navigate('/')
      return
    }

    const answers = {
      roleId,
      experienceLevelId,
      skills,
      resumeName: resume ? resume.name : null,
    }

    localStorage.setItem('careerai_onboarding_answers', JSON.stringify(answers))

    try {
      await apiClient.post(`/users/${userId}/onboarding`, {
        user_id: userId,
        role_id: roleId ? Number(roleId) : null,
        experience_level_id: experienceLevelId ? Number(experienceLevelId) : null,
        skills,
        resume_file_name: resume ? resume.name : null,
      })
      localStorage.setItem('careerai_onboarding_complete', 'true')
      navigate('/dashboard')
    } catch {
      navigate('/dashboard')
    }
  }

  const handleFileChange = (event) => {
    const file = event.target.files && event.target.files[0]
    setResume(file || null)
  }

  return (
    <div className="container py-4">
      <div className="row justify-content-center">
        <div className="col-lg-8">
          <div className="card shadow-sm">
            <div className="card-body">
              <h1 className="h5 mb-3">Career Onboarding</h1>
              <p className="text-muted mb-4">Answer a few questions so CareerAI can better personalize your guidance.</p>
              {optionsError && <div className="alert alert-warning py-2">{optionsError}</div>}
              <form onSubmit={handleSubmit}>
                <div className="mb-3">
                  <label className="form-label">What field or role are you preparing for?</label>
                  <select
                    className="form-select"
                    value={roleId}
                    onChange={(event) => setRoleId(event.target.value)}
                    required
                    disabled={isLoadingOptions || roles.length === 0}
                  >
                    <option value="">{isLoadingOptions ? 'Loading roles...' : 'Select a role'}</option>
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
                    disabled={isLoadingOptions || experienceLevels.length === 0}
                  >
                    <option value="">{isLoadingOptions ? 'Loading experience levels...' : 'Select experience level'}</option>
                    {experienceLevels.map((option) => (
                      <option key={option.id || option.name} value={option.id}>
                        {option.name}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="mb-3">
                  <label className="form-label">What are your current skills?</label>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="For example: Python, React, SQL, HTML, CSS"
                    value={skills}
                    onChange={(event) => setSkills(event.target.value)}
                    required
                  />
                </div>
                <div className="mb-4">
                  <label className="form-label">Resume upload</label>
                  <input type="file" className="form-control" onChange={handleFileChange} />
                </div>
                <button type="submit" className="btn btn-primary">
                  Save and continue
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default CareerQAPage
