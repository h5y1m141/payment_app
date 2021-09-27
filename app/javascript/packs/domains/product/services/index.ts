export const fetchResources = async () => {
  return await fetch('http://localhost:3000/admin/api/v2/products')
}
