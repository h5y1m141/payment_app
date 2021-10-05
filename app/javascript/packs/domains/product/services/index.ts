export const fetchResources = async () => {
  return await fetch(`${process.env.REACT_APP_ORIGIN}/admin/api/v2/products`)
}
