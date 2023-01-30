using System;
using UnityEngine;

namespace Stas
{
    public class AutoRotator : MonoBehaviour
    {
        [Range(0, 5)] [SerializeField] private float speed = 1f;
        [SerializeField] private Vector3 direction;
        
        private void Update()
        {
            transform.Rotate(direction * speed * Time.deltaTime);
        }
    }
}