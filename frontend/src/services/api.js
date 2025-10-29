import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Interceptor para agregar token a las peticiones
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Auth API
export const authAPI = {
  login: (credentials) => api.post('/auth/login', credentials),
};

// Passengers API
export const passengersAPI = {
  getAll: () => api.get('/passengers'),
  getById: (id) => api.get(`/passengers/${id}`),
  create: (data) => api.post('/passengers', data),
  update: (id, data) => api.put(`/passengers/${id}`, data),
  delete: (id) => api.delete(`/passengers/${id}`),
};

// Trips API
export const tripsAPI = {
  getAll: () => api.get('/trips'),
  getAvailable: () => api.get('/trips/available'),
};

export default api;
