import './WelcomePage.css'

function WelcomePage({ onStart }) {
  return (
    <div className="welcome-container">
      <div className="welcome-card">
        <div className="welcome-logo">CareerAI Coach</div>
        <p className="welcome-description">
          Intelligent, secure face-authenticated access to your personalized career coaching dashboard.
        </p>
        <button type="button" className="primary-button" onClick={onStart}>
          Let&apos;s Start
        </button>
      </div>
    </div>
  )
}

export default WelcomePage

