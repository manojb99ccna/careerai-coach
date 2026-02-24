import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { apiClient } from '../api/client'

function MilestoneDetailPage() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [milestone, setMilestone] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [activeTab, setActiveTab] = useState('study') // study, practice, quiz

  // State for Study Tab
  const [togglingMaterial, setTogglingMaterial] = useState(null)
  const [showModal, setShowModal] = useState(false)
  const [modalTitle, setModalTitle] = useState('')
  const [modalContent, setModalContent] = useState('')

  // State for Practice Tab
  const [practiceQuestions, setPracticeQuestions] = useState([])
  const [practiceLoading, setPracticeLoading] = useState(false)
  const [practiceStarted, setPracticeStarted] = useState(false)
  const [practiceAnswers, setPracticeAnswers] = useState({}) // { questionId: selectedOption }
  const [showPracticeFeedback, setShowPracticeFeedback] = useState({}) // { questionId: true/false }

  // State for Quiz Tab
  const [quizQuestions, setQuizQuestions] = useState([])
  const [quizLoading, setQuizLoading] = useState(false)
  const [quizStarted, setQuizStarted] = useState(false)
  const [quizAnswers, setQuizAnswers] = useState({}) // { questionId: selectedOption }
  const [quizSubmitting, setQuizSubmitting] = useState(false)
  const [quizResult, setQuizResult] = useState(null)

  useEffect(() => {
    fetchMilestoneDetails()
  }, [id])

  const fetchMilestoneDetails = async () => {
    setLoading(true)
    setError('')
    try {
      const response = await apiClient.get(`/training/milestones/${id}`)
      setMilestone(response.data)
    } catch (err) {
      console.error('Error fetching milestone details:', err)
      setError('Failed to load milestone details.')
    } finally {
      setLoading(false)
    }
  }

  const handleViewMaterial = (material) => {
    setModalTitle(material.title)
    setModalContent(material.content || 'No content available.')
    setShowModal(true)
  }

  const handleToggleMaterial = async (materialId) => {
    setTogglingMaterial(materialId)
    try {
      await apiClient.post(`/training/milestones/${id}/study/${materialId}/toggle`)
      // Refresh milestone data to update progress
      await fetchMilestoneDetails()
    } catch (err) {
      console.error('Error toggling material:', err)
      alert('Failed to update study material status.')
    } finally {
      setTogglingMaterial(null)
    }
  }

  const startPractice = async () => {
    setPracticeLoading(true)
    try {
      const response = await apiClient.get(`/training/milestones/${id}/questions`, {
        params: { mode: 'practice' }
      })
      setPracticeQuestions(response.data)
      setPracticeStarted(true)
      setPracticeAnswers({})
      setShowPracticeFeedback({})
    } catch (err) {
      console.error('Error starting practice:', err)
      alert('Failed to load practice questions.')
    } finally {
      setPracticeLoading(false)
    }
  }

  const handlePracticeAnswer = (questionId, optionKey) => {
    setPracticeAnswers(prev => ({ ...prev, [questionId]: optionKey }))
    setShowPracticeFeedback(prev => ({ ...prev, [questionId]: true }))
  }

  const handlePracticeComplete = async () => {
    try {
      await apiClient.post(`/training/milestones/${id}/practice/complete`)
      setPracticeStarted(false)
      fetchMilestoneDetails() // Refresh to update status
    } catch (err) {
      console.error('Error completing practice:', err)
      alert('Failed to mark practice as complete.')
    }
  }

  const startQuiz = async () => {
    setQuizLoading(true)
    try {
      const response = await apiClient.get(`/training/milestones/${id}/questions`, {
        params: { mode: 'quiz' }
      })
      setQuizQuestions(response.data)
      setQuizStarted(true)
      setQuizAnswers({})
      setQuizResult(null)
    } catch (err) {
      console.error('Error starting quiz:', err)
      alert('Failed to load quiz questions.')
    } finally {
      setQuizLoading(false)
    }
  }

  const handleQuizAnswer = (questionId, optionKey) => {
    setQuizAnswers(prev => ({ ...prev, [questionId]: optionKey }))
  }

  const submitQuiz = async () => {
    if (Object.keys(quizAnswers).length < quizQuestions.length) {
      if (!window.confirm('You haven\'t answered all questions. Are you sure you want to submit?')) {
        return
      }
    }

    setQuizSubmitting(true)
    try {
      const payload = { answers: quizAnswers }
      const response = await apiClient.post(`/training/milestones/${id}/quiz/submit`, payload)
      setQuizResult(response.data)
      // Refresh milestone status if passed
      if (response.data.passed) {
        fetchMilestoneDetails()
      }
    } catch (err) {
      console.error('Error submitting quiz:', err)
      alert('Failed to submit quiz.')
    } finally {
      setQuizSubmitting(false)
    }
  }

  if (loading) return <div className="container py-4">Loading...</div>
  if (error) return <div className="container py-4 text-danger">{error}</div>
  if (!milestone) return <div className="container py-4">Milestone not found.</div>

  return (
    <div className="container py-4">
      <button className="btn btn-outline-secondary mb-3" onClick={() => navigate('/training')}>
        &larr; Back to Training Plan
      </button>

      <div className="card shadow-sm mb-4">
        <div className="card-body">
          <div className="d-flex justify-content-between align-items-center mb-3">
            <h1 className="h4 mb-0">Milestone {milestone.milestone_number}: {milestone.title}</h1>
            <span className={`badge ${milestone.status === 'completed' ? 'bg-success' : milestone.status === 'in_progress' ? 'bg-primary' : 'bg-secondary'}`}>
              {milestone.status === 'completed' ? 'Completed' : milestone.status === 'in_progress' ? 'In Progress' : 'Locked'}
            </span>
          </div>
          <p className="text-muted">{milestone.description}</p>
        </div>
      </div>

      <ul className="nav nav-tabs mb-4">
        <li className="nav-item">
          <button 
            className={`nav-link ${activeTab === 'study' ? 'active' : ''}`}
            onClick={() => setActiveTab('study')}
          >
            Study Materials
          </button>
        </li>
        <li className="nav-item">
          <button 
            className={`nav-link ${activeTab === 'practice' ? 'active' : ''}`}
            onClick={() => setActiveTab('practice')}
          >
            Practice
          </button>
        </li>
        <li className="nav-item">
          <button 
            className={`nav-link ${activeTab === 'quiz' ? 'active' : ''}`}
            onClick={() => setActiveTab('quiz')}
          >
            Quiz
          </button>
        </li>
      </ul>

      <div className="tab-content">
        {/* Study Tab */}
        {activeTab === 'study' && (
          <div className="card shadow-sm">
            <div className="card-body">
              <h3 className="h5 mb-4">Study Materials</h3>
              {milestone.study_materials && milestone.study_materials.length > 0 ? (
                <div className="list-group">
                  {milestone.study_materials.map(material => (
                    <div key={material.id} className="list-group-item d-flex justify-content-between align-items-center">
                      <div className="me-3">
                        <h6 className="mb-1">{material.title}</h6>
                        <small className="text-muted d-block mb-2">{material.short_description || material.content_type}</small>
                        <button className="btn btn-sm btn-outline-primary" onClick={() => handleViewMaterial(material)}>
                          View Content
                        </button>
                      </div>
                      <div className="form-check">
                        <input
                          className="form-check-input"
                          type="checkbox"
                          checked={material.is_completed}
                          onChange={() => handleToggleMaterial(material.id)}
                          disabled={togglingMaterial === material.id}
                        />
                        <label className="form-check-label ms-2">
                          {material.is_completed ? 'Completed' : 'Mark as Done'}
                        </label>
                      </div>
                    </div>
                  ))}
                </div>
              ) : (
                <p>No study materials available.</p>
              )}
            </div>
          </div>
        )}

        {/* Practice Tab */}
        {activeTab === 'practice' && (
          <div className="card shadow-sm">
            <div className="card-body">
              <h3 className="h5 mb-4">Practice Questions</h3>
              {!practiceStarted ? (
                <div className="text-center py-4">
                  {milestone.practice_completed ? (
                    <div className="alert alert-success mb-4">
                      <i className="bi bi-check-circle-fill me-2"></i>
                      Practice Completed! You can practice again if you want.
                    </div>
                  ) : null}
                  <p>Ready to practice? We'll generate 10 random questions for you.</p>
                  <button className="btn btn-primary" onClick={startPractice} disabled={practiceLoading}>
                    {practiceLoading ? 'Loading...' : 'Start Practice'}
                  </button>
                </div>
              ) : (
                <div className="practice-questions">
                  {practiceQuestions.map((q, index) => (
                    <div key={q.id} className="mb-5 p-3 border rounded">
                      <h5 className="h6 mb-3">Question {index + 1}: {q.question_text}</h5>
                      <div className="d-flex flex-column gap-2">
                        {Object.entries(q.options).map(([key, value]) => {
                          const isSelected = practiceAnswers[q.id] === key;
                          const isCorrect = q.correct_answer === key;
                          const showFeedback = showPracticeFeedback[q.id];
                          
                          let btnClass = 'btn-outline-secondary';
                          if (showFeedback) {
                            if (isCorrect) btnClass = 'btn-success';
                            else if (isSelected) btnClass = 'btn-danger';
                          } else if (isSelected) {
                            btnClass = 'btn-primary';
                          }

                          return (
                            <button
                              key={key}
                              className={`btn ${btnClass} text-start`}
                              onClick={() => !showFeedback && handlePracticeAnswer(q.id, key)}
                              disabled={showFeedback}
                            >
                              <span className="fw-bold me-2">{key.toUpperCase()}.</span> {value}
                            </button>
                          );
                        })}
                      </div>
                      {showPracticeFeedback[q.id] && (
                        <div className={`mt-3 alert ${practiceAnswers[q.id] === q.correct_answer ? 'alert-success' : 'alert-danger'}`}>
                          <strong>{practiceAnswers[q.id] === q.correct_answer ? 'Correct!' : 'Incorrect.'}</strong> {q.explanation}
                        </div>
                      )}
                    </div>
                  ))}
                  <div className="d-flex justify-content-between">
                    <button className="btn btn-outline-secondary" onClick={() => setPracticeStarted(false)}>
                        Cancel
                    </button>
                    <button className="btn btn-success" onClick={handlePracticeComplete}>
                        Finish Practice
                    </button>
                  </div>
                </div>
              )}
            </div>
          </div>
        )}

        {/* Quiz Tab */}
        {activeTab === 'quiz' && (
          <div className="card shadow-sm">
            <div className="card-body">
              <h3 className="h5 mb-4">Final Quiz</h3>
              
              {quizResult ? (
                <div>
                  <div className="text-center py-4 mb-4 border-bottom">
                    <h4 className={quizResult.passed ? 'text-success' : 'text-danger'}>
                      {quizResult.passed ? 'Quiz Passed!' : 'Quiz Failed'}
                    </h4>
                    <p className="display-4">{quizResult.score}%</p>
                    <p>Correct: {quizResult.correct_count} | Incorrect: {quizResult.incorrect_count}</p>
                    <button className="btn btn-primary mt-3" onClick={() => { setQuizResult(null); setQuizStarted(false); fetchMilestoneDetails(); }}>
                      Back to Milestone
                    </button>
                  </div>

                  <h5 className="mb-3">Review Answers</h5>
                  <div className="quiz-review">
                    {quizQuestions.map((q, index) => {
                      const result = quizResult.details[q.id] || {};
                      const userAnswerKey = quizAnswers[q.id];
                      const isCorrect = result.correct;
                      
                      return (
                        <div key={q.id} className={`mb-4 p-3 border rounded ${isCorrect ? 'border-success' : 'border-danger'}`}>
                          <h6 className="mb-2">Question {index + 1}: {q.question_text}</h6>
                          <div className="d-flex flex-column gap-2 mb-2">
                            {Object.entries(q.options).map(([key, value]) => {
                              let btnClass = 'btn-outline-secondary';
                              // Highlight user's answer
                              if (key === userAnswerKey) {
                                btnClass = isCorrect ? 'btn-success' : 'btn-danger';
                              }
                              // Highlight correct answer if user was wrong
                              if (!isCorrect && key === result.correct_answer) {
                                btnClass = 'btn-success';
                              }

                              return (
                                <button
                                  key={key}
                                  className={`btn ${btnClass} text-start`}
                                  disabled
                                >
                                  <span className="fw-bold me-2">{key.toUpperCase()}.</span> {value}
                                </button>
                              );
                            })}
                          </div>
                          <div className={`alert ${isCorrect ? 'alert-success' : 'alert-danger'} mt-2 mb-0`}>
                            <strong>{isCorrect ? 'Correct!' : 'Incorrect.'}</strong> {result.explanation}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              ) : !quizStarted ? (
                <div className="text-center py-4">
                  {(!milestone.practice_completed || milestone.study_materials.some(m => !m.is_completed)) ? (
                    <div className="alert alert-warning mb-4">
                        <i className="bi bi-exclamation-triangle-fill me-2"></i>
                        Please complete all study materials and practice questions before taking the quiz.
                        <ul className="text-start mt-2">
                            {!milestone.study_materials.every(m => m.is_completed) && <li>Study Materials: Incomplete</li>}
                            {!milestone.practice_completed && <li>Practice: Not Completed</li>}
                        </ul>
                    </div>
                  ) : null}
                  <p>Take the final quiz to complete this milestone. You need 70% to pass.</p>
                  <button 
                    className="btn btn-primary" 
                    onClick={startQuiz} 
                    disabled={quizLoading || !milestone.practice_completed || milestone.study_materials.some(m => !m.is_completed)}
                  >
                    {quizLoading ? 'Loading...' : 'Start Quiz'}
                  </button>
                </div>
              ) : (
                <div className="quiz-questions">
                  {quizQuestions.map((q, index) => (
                    <div key={q.id} className="mb-5 p-3 border rounded">
                      <h5 className="h6 mb-3">Question {index + 1}: {q.question_text}</h5>
                      <div className="d-flex flex-column gap-2">
                        {Object.entries(q.options).map(([key, value]) => (
                          <button
                            key={key}
                            className={`btn ${quizAnswers[q.id] === key ? 'btn-primary' : 'btn-outline-secondary'} text-start`}
                            onClick={() => handleQuizAnswer(q.id, key)}
                          >
                            <span className="fw-bold me-2">{key.toUpperCase()}.</span> {value}
                          </button>
                        ))}
                      </div>
                    </div>
                  ))}
                  <button className="btn btn-success btn-lg w-100" onClick={submitQuiz} disabled={quizSubmitting}>
                    {quizSubmitting ? 'Submitting...' : 'Submit Quiz'}
                  </button>
                </div>
              )}
            </div>
          </div>
        )}
      </div>

      {showModal && (
        <div className="modal show d-block" tabIndex="-1" role="dialog" style={{ backgroundColor: 'rgba(0,0,0,0.5)' }}>
          <div className="modal-dialog modal-lg" role="document">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title">{modalTitle}</h5>
                <button type="button" className="btn-close" onClick={() => setShowModal(false)} aria-label="Close"></button>
              </div>
              <div className="modal-body">
                <div style={{ whiteSpace: 'pre-wrap' }}>{modalContent}</div>
              </div>
              <div className="modal-footer">
                <button type="button" className="btn btn-secondary" onClick={() => setShowModal(false)}>Close</button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

export default MilestoneDetailPage
