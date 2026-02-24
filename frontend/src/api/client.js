import axios from 'axios'

const baseURL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000'

export const apiClient = axios.create({
  baseURL,
  headers: {
    'Content-Type': 'application/json',
  },
})

apiClient.interceptors.request.use((config) => {
  const token = localStorage.getItem('careerai_token')
  if (token) {
    const updatedConfig = { ...config }
    updatedConfig.headers = updatedConfig.headers || {}
    updatedConfig.headers.Authorization = `Bearer ${token}`
    return updatedConfig
  }
  return config
})
