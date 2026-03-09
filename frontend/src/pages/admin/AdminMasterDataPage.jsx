import { useEffect, useState } from 'react'
import { adminApiClient } from '../../api/adminClient'

function AdminMasterDataPage() {
  const [roles, setRoles] = useState([])
  const [levels, setLevels] = useState([])
  const [error, setError] = useState('')
  const [isLoading, setIsLoading] = useState(true)
  const [success, setSuccess] = useState('')

  // Create/Edit state
  const [newRoleName, setNewRoleName] = useState('')
  const [newRoleOrder, setNewRoleOrder] = useState('0')
  const [newLevelName, setNewLevelName] = useState('')
  const [newLevelOrder, setNewLevelOrder] = useState('0')
  const [editingRoleId, setEditingRoleId] = useState(null)
  const [editingRoleName, setEditingRoleName] = useState('')
  const [editingRoleOrder, setEditingRoleOrder] = useState('0')
  const [editingLevelId, setEditingLevelId] = useState(null)
  const [editingLevelName, setEditingLevelName] = useState('')
  const [editingLevelOrder, setEditingLevelOrder] = useState('0')

  useEffect(() => {
    let cancelled = false
    const load = async () => {
      setIsLoading(true)
      setError('')
      setSuccess('')
      try {
        const [rolesRes, levelsRes] = await Promise.all([
          adminApiClient.get('/admin/master-data/roles'),
          adminApiClient.get('/admin/master-data/experience-levels'),
        ])
        if (cancelled) return
        setRoles(Array.isArray(rolesRes.data) ? rolesRes.data : [])
        setLevels(Array.isArray(levelsRes.data) ? levelsRes.data : [])
      } catch {
        if (cancelled) return
        setError('Failed to load master data.')
      } finally {
        if (!cancelled) setIsLoading(false)
      }
    }
    load()
    return () => {
      cancelled = true
    }
  }, [])

  const reload = async () => {
    try {
      const [rolesRes, levelsRes] = await Promise.all([
        adminApiClient.get('/admin/master-data/roles'),
        adminApiClient.get('/admin/master-data/experience-levels'),
      ])
      setRoles(Array.isArray(rolesRes.data) ? rolesRes.data : [])
      setLevels(Array.isArray(levelsRes.data) ? levelsRes.data : [])
    } catch {
      // ignore here
    }
  }

  const addRole = async () => {
    const name = newRoleName.trim()
    if (!name) {
      setError('Role name is required.')
      return
    }
    const orderNum = Number(newRoleOrder)
    if (Number.isNaN(orderNum)) {
      setError('Sort order must be a number.')
      return
    }
    setError('')
    try {
      await adminApiClient.post('/admin/master-data/roles', { name, sort_order: orderNum, is_active: true })
      setNewRoleName('')
      setNewRoleOrder('0')
      setSuccess('Role created successfully.')
      setTimeout(() => setSuccess(''), 2500)
      reload()
    } catch (e) {
      setError('Failed to create role. Name may already exist.')
    }
  }

  const addLevel = async () => {
    const name = newLevelName.trim()
    if (!name) {
      setError('Experience level name is required.')
      return
    }
    const orderNum = Number(newLevelOrder)
    if (Number.isNaN(orderNum)) {
      setError('Sort order must be a number.')
      return
    }
    setError('')
    try {
      await adminApiClient.post('/admin/master-data/experience-levels', { name, sort_order: orderNum, is_active: true })
      setNewLevelName('')
      setNewLevelOrder('0')
      setSuccess('Experience level created successfully.')
      setTimeout(() => setSuccess(''), 2500)
      reload()
    } catch (e) {
      setError('Failed to create experience level. Name may already exist.')
    }
  }

  const startEditRole = (r) => {
    setEditingRoleId(r.id)
    setEditingRoleName(r.name)
    setEditingRoleOrder(String(r.sort_order ?? '0'))
  }

  const cancelEditRole = () => {
    setEditingRoleId(null)
    setEditingRoleName('')
    setEditingRoleOrder('0')
  }

  const saveRole = async (role) => {
    const name = editingRoleName.trim()
    if (!name) {
      setError('Role name is required.')
      return
    }
    const orderNum = Number(editingRoleOrder)
    if (Number.isNaN(orderNum)) {
      setError('Sort order must be a number.')
      return
    }
    setError('')
    try {
      await adminApiClient.put(`/admin/master-data/roles/${role.id}`, {
        name,
        sort_order: orderNum,
        is_active: role.is_active ?? true,
      })
      setSuccess('Updated successfully.')
      setTimeout(() => setSuccess(''), 2500)
      cancelEditRole()
      reload()
    } catch (e) {
      setError('Failed to update role. Name may already exist.')
    }
  }

  const deleteRole = async (role) => {
    if (!window.confirm(`Delete role "${role.name}"?`)) return
    setError('')
    try {
      await adminApiClient.delete(`/admin/master-data/roles/${role.id}`)
      setSuccess('Deleted successfully.')
      setTimeout(() => setSuccess(''), 2500)
      reload()
    } catch (e) {
      setError('Cannot delete role because it is in use.')
    }
  }

  const startEditLevel = (l) => {
    setEditingLevelId(l.id)
    setEditingLevelName(l.name)
    setEditingLevelOrder(String(l.sort_order ?? '0'))
  }

  const cancelEditLevel = () => {
    setEditingLevelId(null)
    setEditingLevelName('')
    setEditingLevelOrder('0')
  }

  const saveLevel = async (level) => {
    const name = editingLevelName.trim()
    if (!name) {
      setError('Experience level name is required.')
      return
    }
    const orderNum = Number(editingLevelOrder)
    if (Number.isNaN(orderNum)) {
      setError('Sort order must be a number.')
      return
    }
    setError('')
    try {
      await adminApiClient.put(`/admin/master-data/experience-levels/${level.id}`, {
        name,
        sort_order: orderNum,
        is_active: level.is_active ?? true,
      })
      setSuccess('Updated successfully.')
      setTimeout(() => setSuccess(''), 2500)
      cancelEditLevel()
      reload()
    } catch (e) {
      setError('Failed to update experience level. Name may already exist.')
    }
  }

  const deleteLevel = async (level) => {
    if (!window.confirm(`Delete experience level "${level.name}"?`)) return
    setError('')
    try {
      await adminApiClient.delete(`/admin/master-data/experience-levels/${level.id}`)
      setSuccess('Deleted successfully.')
      setTimeout(() => setSuccess(''), 2500)
      reload()
    } catch (e) {
      setError('Cannot delete experience level because it is in use.')
    }
  }

  return (
    <div className="container py-4">
      <h1 className="h5 mb-3">Master Data</h1>
      {isLoading && <div className="text-muted">Loading...</div>}
      {error && <div className="alert alert-danger py-2">{error}</div>}
      {success && <div className="alert alert-success py-2">{success}</div>}

      {!isLoading && !error && (
        <div className="row g-3">
          <div className="col-lg-6">
            <div className="card">
              <div className="card-body">
                <div className="fw-semibold mb-2">Roles</div>
                <div className="row g-2 align-items-center mb-3">
                  <div className="col">
                    <input
                      className="form-control"
                      placeholder="New role name"
                      value={newRoleName}
                      onChange={(e) => setNewRoleName(e.target.value)}
                    />
                  </div>
                  <div className="col-3">
                    <input
                      className="form-control"
                      placeholder="Sort order"
                      type="number"
                      value={newRoleOrder}
                      onChange={(e) => setNewRoleOrder(e.target.value)}
                    />
                  </div>
                  <div className="col-auto">
                    <button type="button" className="btn btn-primary" onClick={addRole}>
                      Add
                    </button>
                  </div>
                </div>
                <div className="table-responsive">
                  <table className="table table-sm mb-0">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Sort Order</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      {roles.map((r) => {
                        const isEditing = editingRoleId === r.id
                        return (
                          <tr key={r.id}>
                            <td className="small">{r.id}</td>
                            <td className="small">
                              {isEditing ? (
                                <input
                                  className="form-control form-control-sm"
                                  value={editingRoleName}
                                  onChange={(e) => setEditingRoleName(e.target.value)}
                                />
                              ) : (
                                r.name
                              )}
                            </td>
                            <td className="small" style={{ width: '140px' }}>
                              {isEditing ? (
                                <input
                                  type="number"
                                  className="form-control form-control-sm"
                                  value={editingRoleOrder}
                                  onChange={(e) => setEditingRoleOrder(e.target.value)}
                                />
                              ) : (
                                r.sort_order
                              )}
                            </td>
                            <td className="small">
                              {!isEditing ? (
                                <>
                                  <button className="btn btn-sm btn-outline-secondary me-2" onClick={() => startEditRole(r)}>
                                    Edit
                                  </button>
                                  <button className="btn btn-sm btn-outline-danger" onClick={() => deleteRole(r)}>
                                    Delete
                                  </button>
                                </>
                              ) : (
                                <>
                                  <button className="btn btn-sm btn-success me-2" onClick={() => saveRole(r)}>
                                    Save
                                  </button>
                                  <button className="btn btn-sm btn-secondary" onClick={cancelEditRole}>
                                    Cancel
                                  </button>
                                </>
                              )}
                            </td>
                          </tr>
                        )
                      })}
                      {roles.length === 0 && (
                        <tr>
                          <td colSpan={4} className="text-center text-muted py-3">
                            No roles
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>

          <div className="col-lg-6">
            <div className="card">
              <div className="card-body">
                <div className="fw-semibold mb-2">Experience Levels</div>
                <div className="row g-2 align-items-center mb-3">
                  <div className="col">
                    <input
                      className="form-control"
                      placeholder="New experience level name"
                      value={newLevelName}
                      onChange={(e) => setNewLevelName(e.target.value)}
                    />
                  </div>
                  <div className="col-3">
                    <input
                      className="form-control"
                      placeholder="Sort order"
                      type="number"
                      value={newLevelOrder}
                      onChange={(e) => setNewLevelOrder(e.target.value)}
                    />
                  </div>
                  <div className="col-auto">
                    <button type="button" className="btn btn-primary" onClick={addLevel}>
                      Add
                    </button>
                  </div>
                </div>
                <div className="table-responsive">
                  <table className="table table-sm mb-0">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Sort Order</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      {levels.map((l) => {
                        const isEditing = editingLevelId === l.id
                        return (
                          <tr key={l.id}>
                            <td className="small">{l.id}</td>
                            <td className="small">
                              {isEditing ? (
                                <input
                                  className="form-control form-control-sm"
                                  value={editingLevelName}
                                  onChange={(e) => setEditingLevelName(e.target.value)}
                                />
                              ) : (
                                l.name
                              )}
                            </td>
                            <td className="small" style={{ width: '140px' }}>
                              {isEditing ? (
                                <input
                                  type="number"
                                  className="form-control form-control-sm"
                                  value={editingLevelOrder}
                                  onChange={(e) => setEditingLevelOrder(e.target.value)}
                                />
                              ) : (
                                l.sort_order
                              )}
                            </td>
                            <td className="small">
                              {!isEditing ? (
                                <>
                                  <button className="btn btn-sm btn-outline-secondary me-2" onClick={() => startEditLevel(l)}>
                                    Edit
                                  </button>
                                  <button className="btn btn-sm btn-outline-danger" onClick={() => deleteLevel(l)}>
                                    Delete
                                  </button>
                                </>
                              ) : (
                                <>
                                  <button className="btn btn-sm btn-success me-2" onClick={() => saveLevel(l)}>
                                    Save
                                  </button>
                                  <button className="btn btn-sm btn-secondary" onClick={cancelEditLevel}>
                                    Cancel
                                  </button>
                                </>
                              )}
                            </td>
                          </tr>
                        )
                      })}
                      {levels.length === 0 && (
                        <tr>
                          <td colSpan={4} className="text-center text-muted py-3">
                            No experience levels
                          </td>
                        </tr>
                      )}
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

export default AdminMasterDataPage
