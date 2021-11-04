export const fetchResources = async (idToken: string) => {
  const url = `${process.env.REACT_APP_ORIGIN}/admin/api/v2/orders`
  return await fetch(url, {
    headers: {
      Authorization: `Bearer ${idToken}`,
    },
  })
}
